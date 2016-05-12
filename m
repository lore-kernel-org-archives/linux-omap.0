From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 10/14] usb: otg: add hcd companion support
Date: Thu, 12 May 2016 11:34:04 +0300
Message-ID: <57343FFC.9090105@ti.com>
References: <57333DFF.3090609@ti.com>
 <Pine.LNX.4.44L0.1605111043030.1882-100000@iolanthe.rowland.org>
 <SG2PR06MB09194AB523C3ABDB425285C7D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <SG2PR06MB09194AB523C3ABDB425285C7D8730-ESzmfEwOt/zNQ8RBPPB5A20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/05/16 07:00, Yoshihiro Shimoda wrote:
> Hi,
> 
>> From: Alan Stern
>> Sent: Wednesday, May 11, 2016 11:47 PM
>>
>> On Wed, 11 May 2016, Roger Quadros wrote:
>>
>>>> What I mean is if you have 2 EHCI controllers with 2 companion
>>>> controllers, don't you need to know which companion goes with which EHCI
>>>> controller? Just like you do for the otg-controller property.
>>>>
>>>
>>> That is a very good point. I'm not very sure and it seems that current code won't work
>>> with multiple EHCI + companion instances.
> 
> I may misunderstand this topic, but if I use the following environment, it works correctly.
> 
> < My environment >
> - an otg controller: Sets hcd-needs-companion.
> - ehci0 and ohci0 and a function: They connect to the otg controller using "otg-controller" property.
> - ehci1 and ohci1: No "otg-controller" property.
> - ehci2 and ohci2: No "otg-controller" property.
> 
> In this environment, all hosts works correctly.
> Also I think if we have 2 otg controlelrs, it should be work because otg_dev instance differs.

The topic is about more than one otg controllers and how to tie the right ehci and ohci
to the correct otg_dev instance especially in cases where we can't depend on probe order.

> Or, does this topic assume an otg controller handles 2 EHCI controllers?
> I'm not sure such environment actually exists.

No it is not about that.

> 
>>> Alan, does USB core even know which EHCI and OHCI are linked to the same port
>>> or the handoff is software transparent?
>>
>> The core knows.  It doesn't use the information for a whole lot of
>> things, but it does use it in a couple of places.  Search for
>> "companion" in core/hcd-pci.c and you'll see.
> 
> Thank you for the information. I didn't know this code.
> If my understanding is correct, the core/hcd-pci.c code will not be used by non-PCI devices.

That is correct.

> In other words, nobody sets "hcd->self.hs_companion" if we use such a device.
> So, I will try to add such a code if needed.

I think OTG core would have to rely on USB core in providing the right companion device,
just like we rely on it for the primary vs shared HCD case.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
