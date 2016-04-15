From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Fri, 15 Apr 2016 13:57:44 +0300
Message-ID: <5710C928.2020704@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <SG2PR06MB091922CDE73AE061A79E90E4D8900@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <57064850.3060405@ti.com>
 <SG2PR06MB09197595F9D810CF8A22D860D8910@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570B8268.6090700@ti.com>
 <SG2PR06MB0919398D3CF4944A6EA2754DD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570F7827.8050707@ti.com>
 <SG2PR06MB09195754753D7FDDAB05D3FDD8970@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <570F7FB3.2040807@ti.com>
 <SG2PR06MB09195F411F6BBE840F7A22D2D8680@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <SG2PR06MB09195F411F6BBE840F7A22D2D8680-ESzmfEwOt/zNQ8RBPPB5A20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 15/04/16 12:59, Yoshihiro Shimoda wrote:
> Hi,
> 
>> From: Roger Quadros
>> Sent: Thursday, April 14, 2016 8:32 PM
>>
>> On 14/04/16 14:15, Yoshihiro Shimoda wrote:
>>> Hi,
>>>
> < snip >
>>>>> @@ -865,7 +867,8 @@ int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>>>>>  	 * we're ready only if we have shared HCD
>>>>>  	 * or we don't need shared HCD.
>>>>>  	 */
>>>>> -	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
>>>>> +	if (otg->shared_hcd.hcd || (!otg->caps->needs_companion &&
>>>>> +				    !otg->primary_hcd.hcd->shared_hcd)) {
>>>>>  		otg->host = hcd_to_bus(hcd);
>>>>>  		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>>>>>
>>>>
>>>> These changes look good to me. Thanks.
>>>
>>> Thank you for the comment.
>>> If we change the "needs_companion" place to the otg_config,
>>> do we need to add a flag into the otg, instead of otg->caps?
>>
>> Yes we can add a flag in struct usb_otg.
> 
> Thank you for the comment.
> 
> I made a fixed patch.
> So, should I send this patch to ML after you sent v7 patches?
> Or, would you apply this patch before you send v7 patches?
> 

Thanks for working on this and testing the series. I will pick your patch
as part of v7.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
