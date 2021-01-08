 
var ready = function() {

  var gaProperty = 'UA-xxxxx-xxxx';
  var disableStr = 'ga-disable-' + gaProperty;
  var gaCookie = getCookie(disableStr);

  //target the id to insert the modal
  var modalInsert = document.getElementById('cookieOpts');

  // create the array for tabbing in the modal 
  let tabData = [];

          const selector =
  'a[href], area[href], input:not([disabled]):not([type="hidden"]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), iframe, object, embed, *[tabindex], *[contenteditable]';


    if (gaCookie == null) {
    // do cookie doesn't exist stuff;
    //disable ga cookie before the ga code
    window[disableStr] = true;


    var getUrl = location.href;
    var convertedUrl= getUrl.toLowerCase();



      if(typeof modalInsert !== 'undefined' && modalInsert !== null) {

    

        // ensure the pop up does not appear on the cookies page
        // GA wont track this page so we wont know if people are going to it
        if(convertedUrl.indexOf('privacy/cookies') == -1)  {
    
          //insert the modal
          var body = document.body;
          body.classList.add("modal-open");

            
            modalInsert.innerHTML = `
              <div class="modal fade " id="privacyModal" style="display:block" aria-modal="true">
                <div class="modal-dialog modal-vertical-centered modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h3 class="modal-title">We value your privacy</h3>
                    </div>
                    <div class="modal-body">
                      <p>This website uses cookies to help us to improve both content and user experience</p>

                      <p>To find out which cookies we use and/or opt out of optional cookies please click 
                          <button class="btn btn-link btn-plain" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            More about Cookies
                          </button></p>
                      <p>To accept all cookies please click the button below</p>
                      <p><button class="btn btn-primary" id="enable-ga">I'm fine with cookies</button></p>
                      
                      <div id="accordion">

                       

                        <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">

                          <p>This site uses several cookies that are essential for it to function correctly. Find out more about the <a class="font-weight-normal" href="/privacy/cookies/">cookies</a> used by this site.</p>
   
       
                          <p>We use Google Analytics to track visitor interaction with our website to help us improve the service we offer. The data collected is totally anonymous. You can opt out of Google Analytics tracking below:</p>

                          <p> <button class="btn btn-link" id="disable-ga">Turn off data collection by Google Analytics</button</p>
     
                 </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              `;

          //generate the div at the bottom near the closing body tag for modal black background
          var div = document.createElement('div');
          var modal = document.getElementById('privacyModal');



          // div.setAttribute('class', 'modal-backdrop fade show');
          // body.append(div);


          $('#enable-ga').click(function (event) {
              setCookie('true');
              event.preventDefault(); // Prevent link from following its href
          });

          $('#disable-ga').click(function (event) {
              setCookie('false');
              event.preventDefault(); // Prevent link from following its href
          });




          preventTabOutside(modal);

        
        } // end if(convertedUrl.indexOf('info-sec/cookies') == -1)


    }

    } else {
        if (document.cookie.indexOf(disableStr + '=true') > -1) {
            // set to disabled
            window[disableStr] = true;

        } else {
            window[disableStr] = false;
        }
    }

  
    

    

    if (gaCookie) {
        
      } else {

        // check is not the privacy cookies page or the js will have error as privacyModal cannot be found
        if(convertedUrl.indexOf('privacy/cookies') == -1)  {
          var privacyModal = document.getElementById("privacyModal");
          privacyModal.classList.add("in");
        }
      }



      $('#clear-cookies').click(function (event) {
        clearCookie()
        event.preventDefault(); // Prevent link from following its href
      });


    function setCookie(cookieValue) {
        var cookieValue = cookieValue;
        var now = new Date();
        var time = now.getTime();
        var expireTime = time + 10800000; //3 hours from timenow
        now.setTime(expireTime);

        // Disable tracking if the opt-out cookie exists.
        document.cookie = disableStr + '=' + cookieValue +'; expires='+now.toGMTString()+'; path=/';
        var modal = document.getElementById('privacyModal');
        enableTabOutside(modal);
        window[disableStr] = true;

        window.location.reload();
        
    };



    function getCookie(name) {
        var dc = document.cookie;
        var prefix = name + "=";
        var begin = dc.indexOf("; " + prefix);
        if (begin == -1) {
            begin = dc.indexOf(prefix);
            if (begin != 0) return null;
        }
        else
        {
            begin += 2;
            var end = document.cookie.indexOf(";", begin);
            if (end == -1) {
            end = dc.length;
            }
        }
        // because unescape has been deprecated, replaced with decodeURI
        //return unescape(dc.substring(begin + prefix.length, end));
        return decodeURI(dc.substring(begin + prefix.length, end));
    } 

    function clearCookie() {
        document.cookie = disableStr + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
        window[disableStr] = true;
        window.location.reload();
    }


    // should be called when modal opens
    function preventTabOutside(modal) {
      const tabbableElements = document.querySelectorAll(selector);
      tabData = Array.from(tabbableElements)
        // filter out any elements within the modal
        .filter((elem) => !modal.contains(elem))
        // store refs to the element and its original tabindex
        .map((elem) => {
          // capture original tab index, if it exists
          const tabIndex = elem.hasAttribute("tabindex")
            ? elem.getAttribute("tabindex")
            : null;
          // temporarily set the tabindex to -1
          elem.setAttribute("tabindex", -1);
          return { elem, tabIndex };
        });
    }

    // should be called when modal closes
    function enableTabOutside() {
      tabData.forEach(({ elem, tabIndex }) => {
        if (tabIndex === null) {
          elem.removeAttribute("tabindex");
        } else {
          elem.setAttribute("tabindex", tabIndex);
        }
      });
      tabData = [];
    }

 };


  window.addEventListener("load", () => {
    const links = document.querySelectorAll(
      "a[data-background-color]"
    );
    links.forEach((element) => {
      element.addEventListener("click", (event) => {
        event.preventDefault();

        const {backgroundColor, textColor} = element.dataset;
        paintIt(element, backgroundColor, textColor);
      });
    });
  });



$(document).ready(ready);
$(document).on('page:change', ready);