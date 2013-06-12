From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/5] dwc3: omap: adapt dwc3 to use extcon framework
Date: Wed, 12 Jun 2013 09:59:15 +0900
Message-ID: <51B7C7E3.9050706@samsung.com>
References: <1370276020-17446-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1370276020-17446-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: myungjoo.ham@samsung.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, benoit.cousson@linaro.org, anish198519851985@gmail.com, pmeerw@pmeerw.net
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

I confused patch number. I applied patch2,3 on extcon-linus branch.

  extcon: Kconfig: Make extcon config type as bool
  extcon: add EXPORT_SYMBOL_GPL for exported functions


And I will reply comment about patch1 soon.

  extcon: Add an API to get extcon device from dt node


Thanks,
Chanwoo Choi

On 06/04/2013 01:13 AM, Kishon Vijay Abraham I wrote:
> The first three patches deals with cleanup of extcon inorder to get
> through compilation without any issues. It also adds an API to get
> extcon device from dt node which I felt was missing.
>
> The next two patches deals with adapt dwc3 to use extcon framework.
> The 4th patch (usb: dwc3: omap: improve error handling of dwc3_omap_probe)
> should have ideally been sent to Felipe, however since
> there will be merge conflicts with the 5th patch
> (usb: dwc3: use extcon fwrk to receive connect/disconnect)
> in this series, I've sent in the same series.
>
> Once this patch series get merged, dwc3 in omap would be functional
> in device mode. However there is still some discussion on modelling
> SMPS10 regulator. Once that gets finalized, dwc3 should be functional
> in host mode as well.
>
> Kishon Vijay Abraham I (5):
>   extcon: Add an API to get extcon device from dt node
>   extcon: Kconfig: Make extcon config type as bool
>   extcon: add EXPORT_SYMBOL_GPL for exported functions
>   usb: dwc3: omap: improve error handling of dwc3_omap_probe
>   usb: dwc3: use extcon fwrk to receive connect/disconnect
>
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
>  drivers/extcon/Kconfig                             |    2 +-
>  drivers/extcon/extcon-class.c                      |   42 +++++++
>  drivers/usb/dwc3/dwc3-omap.c                       |  133 ++++++++++++++++----
>  include/linux/extcon.h                             |    8 ++
>  include/linux/usb/dwc3-omap.h                      |   30 -----
>  6 files changed, 168 insertions(+), 52 deletions(-)
>  delete mode 100644 include/linux/usb/dwc3-omap.h
>

