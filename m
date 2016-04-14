From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Thu, 14 Apr 2016 14:32:03 +0300
Message-ID: <570F7FB3.2040807@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <57064850.3060405@ti.com>
 <SG2PR06MB09197595F9D810CF8A22D860D8910@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570B8268.6090700@ti.com>
 <SG2PR06MB0919398D3CF4944A6EA2754DD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570F7827.8050707@ti.com>
 <SG2PR06MB09195754753D7FDDAB05D3FDD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <SG2PR06MB09195754753D7FDDAB05D3FDD8970-ESzmfEwOt/zNQ8RBPPB5A20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 14/04/16 14:15, Yoshihiro Shimoda wrote:
> Hi,
> 
>> From: Roger Quadros
>> Sent: Thursday, April 14, 2016 8:00 PM
>>
>> On 14/04/16 11:36, Yoshihiro Shimoda wrote:
>>> Hi,
>>>
> < snip >
>>> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
>>> index e3d0161..8b74715 100644
>>> --- a/drivers/usb/common/common.c
>>> +++ b/drivers/usb/common/common.c
>>> @@ -233,6 +233,8 @@ int of_usb_update_otg_caps(struct device_node *np,
>>>  	if (of_find_property(np, "adp-disable", NULL) ||
>>>  				(otg_caps->otg_rev < 0x0200))
>>>  		otg_caps->adp_support = false;
>>> +	if (of_find_property(np, "hcd-needs-companion", NULL))
>>> +		otg_caps->needs_companion = true;
>>
>> I'm not sure if otg_caps structure is a right place for this. Maybe Peter can confirm
>> if this is OK or not.
>>
>> I was thinking more about adding this bit in the otg_config structure.
> 
> I see. I also think the otg_config is more suitable.
> 
>>>
>>>  	return 0;
>>>  }
>>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>>> index 41e762a..e0df839 100644
>>> --- a/drivers/usb/common/usb-otg.c
>>> +++ b/drivers/usb/common/usb-otg.c
>>> @@ -823,13 +823,15 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>  	/* HCD will be started by OTG fsm when needed */
>>>  	mutex_lock(&otg->fsm.lock);
>>>  	if (otg->primary_hcd.hcd) {
>>> -		/* probably a shared HCD ? */
>>> -		if (usb_otg_hcd_is_primary_hcd(hcd)) {
>>> +		/* probably a shared HCD or a companion OHCI HCD ? */
>>> +		if (!otg->caps->needs_companion &&
>>> +		    usb_otg_hcd_is_primary_hcd(hcd)) {
>>>  			dev_err(otg_dev, "otg: primary host already registered\n");
>>>  			goto err;
>>>  		}
>>>
>>> -		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
>>> +		if (otg->caps->needs_companion ||
>>> +		    (hcd->shared_hcd == otg->primary_hcd.hcd)) {
>>>  			if (otg->shared_hcd.hcd) {
>>>  				dev_err(otg_dev, "otg: shared host already registered\n");
>>>  				goto err;
>>> @@ -865,7 +867,8 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>  	 * we're ready only if we have shared HCD
>>>  	 * or we don't need shared HCD.
>>>  	 */
>>> -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
>>> +	if (otg->shared_hcd.hcd || (!otg->caps->needs_companion &&
>>> +				    !otg->primary_hcd.hcd->shared_hcd)) {
>>>  		otg->host = hcd_to_bus(hcd);
>>>  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>>>
>>
>> These changes look good to me. Thanks.
> 
> Thank you for the comment.
> If we change the "needs_companion" place to the otg_config,
> do we need to add a flag into the otg, instead of otg->caps?

Yes we can add a flag in struct usb_otg.

cheers,
-roger

> 
>>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>>> index b094352..64a7db8 100644
>>> --- a/include/linux/usb/otg.h
>>> +++ b/include/linux/usb/otg.h
>>> @@ -112,12 +112,14 @@ struct usb_otg {
>>>   * @hnp_support: Indicates if the device supports HNP.
>>>   * @srp_support: Indicates if the device supports SRP.
>>>   * @adp_support: Indicates if the device supports ADP.
>>> + * @needs_companion: Indicates if the device needs a companion controller.
>>
>> Description is not exact. How about this.
>> "Indicates if host controller needs a companion controller"
>>
>> Is hcd_needs_companion is better than just needs_companion?
> 
> I agree with you.
> 
> So, I will modify my local patch and test it tomorrow.
> 
> Best regards,
> Yoshihiro Shimoda
> 
>>
>>>   */
>>>  struct usb_otg_caps {
>>>  	u16 otg_rev;
>>>  	bool hnp_support;
>>>  	bool srp_support;
>>>  	bool adp_support;
>>> +	bool needs_companion;
>>>  };
>>>
>>>  /**
>>>
>>
>> cheers,
>> -roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
