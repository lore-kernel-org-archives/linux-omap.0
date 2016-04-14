From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Thu, 14 Apr 2016 13:59:51 +0300
Message-ID: <570F7827.8050707@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <57064850.3060405@ti.com>
 <SG2PR06MB09197595F9D810CF8A22D860D8910@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570B8268.6090700@ti.com>
 <SG2PR06MB0919398D3CF4944A6EA2754DD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB0919398D3CF4944A6EA2754DD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 14/04/16 11:36, Yoshihiro Shimoda wrote:
> Hi,
> 
>> From: Roger Quadros
>> Sent: Monday, April 11, 2016 7:55 PM
>>
>> On 08/04/16 14:22, Yoshihiro Shimoda wrote:
>>> Hi,
>>>
>>>> From: Roger Quadros
>>>> Sent: Thursday, April 07, 2016 8:45 PM
>>>>
>>>> Hi,
>>>>
>>>> On 07/04/16 11:52, Yoshihiro Shimoda wrote:
>>>>> Hi,
>>>>>
>>>>>> From: Roger Quadros
>>>>>> Sent: Tuesday, April 05, 2016 11:05 PM
>>> < snip >
>>>>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>>>>> index 41e762a..4d7f043 100644
>>>>> --- a/drivers/usb/common/usb-otg.c
>>>>> +++ b/drivers/usb/common/usb-otg.c
>>>>> @@ -825,11 +825,16 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>>>  	if (otg->primary_hcd.hcd) {
>>>>>  		/* probably a shared HCD ? */
>>>>>  		if (usb_otg_hcd_is_primary_hcd(hcd)) {
>>>>> +			if (hcd->driver->flags & HCD_USB11) {
>>>>> +				dev_info(otg_dev, "this assumes usb 1.1 hc is as shared_hcd\n");
>>>>> +				goto check_shared_hcd;
>>>>> +			}
>>>>>  			dev_err(otg_dev, "otg: primary host already registered\n");
>>>>>  			goto err;
>>>>>  		}
>>>>>
>>>>>  		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
>>>>> +check_shared_hcd:
>>>>>  			if (otg->shared_hcd.hcd) {
>>>>>  				dev_err(otg_dev, "otg: shared host already registered\n");
>>>>>  				goto err;
>>>>>
>>>>> What do you think this local hack?
>>>>
>>>> Is it guaranteed that EHCI hcd registers before OHCI hcd?
>>>
>>> Thank you for the comment. No, it is not guaranteed.
>>>
>>>> If not we need to improve the code still.
>>>> We will also need to remove the constraint that primary_hcd must be registered
>>>> first in usb_otg_register_hcd(). I think that constraint is no longer
>>>> needed anyways.
>>>
>>> I got it.
>>> So, I made a patch to avoid the constraint using an additional property "otg-hcds".
>>> The patch is in this end of email. What do you think about the patch?
>>
>> This might only solve the issue for device tree but what about non-device tree?
>> We need to deal with both cases.
> 
> Thank you for the comment. I got it.
> 
>>>> If EHCI & OHCI HCDs register before OTG driver then things will break unless
>>>> we fix usb_otg_hcd_wait_add(). We need to add this HCD_USB11 check there to
>>>> populate wait->shared_hcd.
>>>
>>> I see. In my environment, since EHCI & OHCI HCDs need phy driver and phy driver
>>> will calls usb_otg_register(), the order is right. In other words,
>>> EHCI & OHCI HCDs never register before OTG driver because even if EHCI driver
>>> is probed first, the driver will be deferred (EHCI driver needs the phy driver).
>>
>> But still we cannot assume this is true for all platforms. OTG driver can also
>> be a separate entity than PHY driver.
> 
> I understood it.
> 
>>>>> I also wonder if array of hcd may be good for both xHCI and EHCI/OHCI.
>>>>> For example of xHCI:
>>>>>  - otg->hcds[0] = primary_hcd
>>>>>  - otg->hcds[1] = shared_hcd
>>>>>
>>>>> For example of EHCI/OHCI:
>>>>>  - otg->hcds[0] = primary_hcd of EHCI
>>>>>  - otg->hcds[1] = primary_hcd of OHCI
>>>>
>>>> The bigger problem is that how do we know in the OHCI/EHCI case that we need to wait
>>>> for both of them before starting the OTG FSM?
>>>> Some systems might use just OHCI or just EHCI.
>>>>
>>>> There is no guarantee that OTG driver registers before the HCDs so this piece
>>>> of information must come from the HCD itself. i.e. whether it needs a companion or not.
>>>
>>> I understood these problems. I wonder if my patch can resolve these problems.
>>>
>>> Best regards,
>>> Yoshihiro Shimoda
>>> ---
>>> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
>>> index f6866c1..518b9eb 100644
>>> --- a/Documentation/devicetree/bindings/usb/generic.txt
>>> +++ b/Documentation/devicetree/bindings/usb/generic.txt
>>> @@ -27,6 +27,12 @@ Optional properties:
>>>   - otg-controller: phandle to otg controller. Host or gadget controllers can
>>>  			contain this property to link it to a particular OTG
>>>  			controller.
>>> + - otg-hcds: phandle to host controller(s). An OTG controller can contain this
>>> +	     property. The first one is as "primary", and (optional) the second
>>> +	     one is as "shared".
>>> +	     - For example for xHCI:		otg-hcds = <&xhci>, <&xhci>;
>>> +	     - For example for EHCI/OHCI:	otg-hcds = <&ehci>, <&ohci>;
>>> +	     - For example for just EHCI:	otg-hcds = <&ehci>;
>>>
>>
>> This is kind of duplicating the information. We are already specifying in the
>> hcd nodes as to which otg controller it is linked to.
>>
>> Instead, how about just adding a boolean property in the otg node saying that
>> HCD needs companion. e.g.
>> 	hcd-needs-compainion: must be present if otg controller is dealing with
>> 			EHCI host controller that needs a companion OHCI host controller.
>>
>> This can also be added in struct usb_otg_config so that it can deal with non-DT cases.
>>
>> So if this property is true, the OTG core will wait for 2 primary HCDs to be registered.
> 
> Thank you for your suggestion. I agree with you.
> So, I made such a patch which. It is simple than my previous patch.
> What do you think?
> 
> Best regards,
> Yoshihiro Shimoda
> 
> ---
>  Documentation/devicetree/bindings/usb/generic.txt |  3 +++
>  drivers/usb/common/common.c                       |  2 ++
>  drivers/usb/common/usb-otg.c                      | 11 +++++++----
>  include/linux/usb/otg.h                           |  2 ++
>  4 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
> index f6866c1..1db1c33 100644
> --- a/Documentation/devicetree/bindings/usb/generic.txt
> +++ b/Documentation/devicetree/bindings/usb/generic.txt
> @@ -27,6 +27,9 @@ Optional properties:
>   - otg-controller: phandle to otg controller. Host or gadget controllers can
>  			contain this property to link it to a particular OTG
>  			controller.
> + - hcd-needs-companion: must be present if otg controller is dealing with
> +			EHCI host controller that needs a companion OHCI host
> +			controller.
>  
>  This is an attribute to a USB controller such as:
>  
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index e3d0161..8b74715 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -233,6 +233,8 @@ int of_usb_update_otg_caps(struct device_node *np,
>  	if (of_find_property(np, "adp-disable", NULL) ||
>  				(otg_caps->otg_rev < 0x0200))
>  		otg_caps->adp_support = false;
> +	if (of_find_property(np, "hcd-needs-companion", NULL))
> +		otg_caps->needs_companion = true;

I'm not sure if otg_caps structure is a right place for this. Maybe Peter can confirm
if this is OK or not.

I was thinking more about adding this bit in the otg_config structure.

>  
>  	return 0;
>  }
> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
> index 41e762a..e0df839 100644
> --- a/drivers/usb/common/usb-otg.c
> +++ b/drivers/usb/common/usb-otg.c
> @@ -823,13 +823,15 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>  	/* HCD will be started by OTG fsm when needed */
>  	mutex_lock(&otg->fsm.lock);
>  	if (otg->primary_hcd.hcd) {
> -		/* probably a shared HCD ? */
> -		if (usb_otg_hcd_is_primary_hcd(hcd)) {
> +		/* probably a shared HCD or a companion OHCI HCD ? */
> +		if (!otg->caps->needs_companion &&
> +		    usb_otg_hcd_is_primary_hcd(hcd)) {
>  			dev_err(otg_dev, "otg: primary host already registered\n");
>  			goto err;
>  		}
>  
> -		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
> +		if (otg->caps->needs_companion ||
> +		    (hcd->shared_hcd == otg->primary_hcd.hcd)) {
>  			if (otg->shared_hcd.hcd) {
>  				dev_err(otg_dev, "otg: shared host already registered\n");
>  				goto err;
> @@ -865,7 +867,8 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>  	 * we're ready only if we have shared HCD
>  	 * or we don't need shared HCD.
>  	 */
> -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
> +	if (otg->shared_hcd.hcd || (!otg->caps->needs_companion &&
> +				    !otg->primary_hcd.hcd->shared_hcd)) {
>  		otg->host = hcd_to_bus(hcd);
>  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>  

These changes look good to me. Thanks.

> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index b094352..64a7db8 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -112,12 +112,14 @@ struct usb_otg {
>   * @hnp_support: Indicates if the device supports HNP.
>   * @srp_support: Indicates if the device supports SRP.
>   * @adp_support: Indicates if the device supports ADP.
> + * @needs_companion: Indicates if the device needs a companion controller.

Description is not exact. How about this.
"Indicates if host controller needs a companion controller"

Is hcd_needs_companion is better than just needs_companion?


>   */
>  struct usb_otg_caps {
>  	u16 otg_rev;
>  	bool hnp_support;
>  	bool srp_support;
>  	bool adp_support;
> +	bool needs_companion;
>  };
>  
>  /**
> 

cheers,
-roger
