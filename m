From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v6] usb: dwc3: use extcon fwrk to receive connect/disconnect
Date: Tue, 16 Jul 2013 08:03:56 +0900
Message-ID: <51E47FDC.1020202@samsung.com>
References: <1373902742-9495-1-git-send-email-kishon@ti.com>
 <20130715155106.GE32035@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20130715155106.GE32035@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Kishon Vijay Abraham I <kishon@ti.com>, myungjoo.ham@samsung.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, benoit.cousson@linaro.org
List-Id: linux-omap@vger.kernel.org

On 07/16/2013 12:51 AM, Felipe Balbi wrote:
> On Mon, Jul 15, 2013 at 09:09:02PM +0530, Kishon Vijay Abraham I wrote:
>> Modified dwc3-omap to receive connect and disconnect notification using
>> extcon framework. Also did the necessary cleanups required after
>> adapting to extcon framework.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>> This patch should be applied after all of the extcon patchset will be applied
>> because this patch has dependency of extcon patch related to DT.
>> http://goo.gl/Tu3qW
>>
>> Changes from v5:
>> * rebased to 3.11-rc1
>> Changes from v4:
>> * checked the return values of extcon_register_interest and print an error
>> message. Note that I dint do return since there might be cases where
>> one of USB (device mode) or USB-HOST (host mode) might succeed.
>> * Added depends on of EXTCON in usb_dwc3. Only some platforms might
>> be using EXTCON, but inorder to avoid compilation errors, added
>> depends on
>> Changes from v3:
>> * did #include of of_extcon.h after Chanwoo resent the patch separating
>> extcon-class.c from of_extcon.c
>> Changes from v2:
>> * updated the Documentation with dwc3 dt binding information.
>> * used of_extcon_get_extcon_dev to get extcon device from device tree data.
>> Changes from v1:
>> * regulator enable/disable is now done here instead of palmas-usb as some users
>> of palmas-usb wont need regulator.
>>  Documentation/devicetree/bindings/usb/omap-usb.txt |    5 +
>>  drivers/usb/dwc3/Kconfig                           |    1 +
>>  drivers/usb/dwc3/dwc3-omap.c                       |  125 +++++++++++++++++---
>>  3 files changed, 112 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> index 57e71f6..9088ab0 100644
>> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
>> @@ -53,6 +53,11 @@ OMAP DWC3 GLUE
>>     It should be set to "1" for HW mode and "2" for SW mode.
>>   - ranges: the child address space are mapped 1:1 onto the parent address space
>>  
>> +Optional Properties:
>> + - extcon : phandle for the extcon device omap dwc3 uses to detect
>> +   connect/disconnect events.
>> + - vbus-supply : phandle to the regulator device tree node if needed.
>> +
>>  Sub-nodes:
>>  The dwc3 core should be added as subnode to omap dwc3 glue.
>>  - dwc3 :
>> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
>> index 757aa18..08a9fab 100644
>> --- a/drivers/usb/dwc3/Kconfig
>> +++ b/drivers/usb/dwc3/Kconfig
>> @@ -1,6 +1,7 @@
>>  config USB_DWC3
>>  	tristate "DesignWare USB3 DRD Core Support"
>>  	depends on (USB || USB_GADGET) && GENERIC_HARDIRQS
>> +	depends on EXTCON
> 
> can you rebase this on top of 'testing' branch. I have a patch there
> which give glue layers their own Kconfig symbols. If you do that, I can
> queue this patch myself for v3.12, unless we have dependencies on other
> patches which aren't in mainline, in which case, I'd ask to simply
> remove this Kconfig change for now.
> 

Dear Felipe and Kishon,

We have some confusion about applying this patch.

I already applied this patch on extcon-next branch for v3.12. This patch has the dependency on below extcon patch.
[PATCH] usb: dwc3: use extcon fwrk to receive connect/disconnect
- http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=68517aac722c8c3e0c153b3ede40aace25cb66fa
[PATCH] extcon: Add an API to get extcon device from dt node
- http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=cb28faede03de7abe82336c3648771a01f5fe225

If Felipe would apply this patch usb.git for v3.12, I think you should include extcon patch together.
[PATCH] extcon: Add an API to get extcon device from dt node
- http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=cb28faede03de7abe82336c3648771a01f5fe225

The dependency related to patch cause this confusion.
What is your opinion?

Thanks,
Chanwoo Choi

