From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 10/14] usb: otg: add hcd companion support
Date: Mon, 16 May 2016 11:35:51 +0300
Message-ID: <57398667.3010201@ti.com>
References: <57333DFF.3090609@ti.com>
 <Pine.LNX.4.44L0.1605111043030.1882-100000@iolanthe.rowland.org>
 <SG2PR06MB09194AB523C3ABDB425285C7D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <57343FFC.9090105@ti.com> <57344D7B.3050005@ti.com>
 <SG2PR06MB091923EEBAA67EC1D1E48B6DD8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <5734737C.6070003@ti.com> <20160516021350.GA24609@shlinux2.ap.freescale.net>
 <57397E57.8060903@ti.com> <20160516081326.GC24609@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160516081326.GC24609-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 16/05/16 11:13, Peter Chen wrote:
> On Mon, May 16, 2016 at 11:01:27AM +0300, Roger Quadros wrote:
>> On 16/05/16 05:13, Peter Chen wrote:
>>> On Thu, May 12, 2016 at 03:13:48PM +0300, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 12/05/16 13:31, Yoshihiro Shimoda wrote:
>>>>> Hi,
>>>>>
>>>>>> From: Roger Quadros
>>>>>> Sent: Thursday, May 12, 2016 6:32 PM
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 12/05/16 11:34, Roger Quadros wrote:
>>>>>>> On 12/05/16 07:00, Yoshihiro Shimoda wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>>> From: Alan Stern
>>>>>>>>> Sent: Wednesday, May 11, 2016 11:47 PM
>>>>>>>>>
>>>>>>>>> On Wed, 11 May 2016, Roger Quadros wrote:
>>>>>>>>>
>>>>>>>>>>> What I mean is if you have 2 EHCI controllers with 2 companion
>>>>>>>>>>> controllers, don't you need to know which companion goes with which EHCI
>>>>>>>>>>> controller? Just like you do for the otg-controller property.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> That is a very good point. I'm not very sure and it seems that current code won't work
>>>>>>>>>> with multiple EHCI + companion instances.
>>>>>>>>
>>>>>>>> I may misunderstand this topic, but if I use the following environment, it works correctly.
>>>>>>>>
>>>>>>>> < My environment >
>>>>>>>> - an otg controller: Sets hcd-needs-companion.
>>>>>>>> - ehci0 and ohci0 and a function: They connect to the otg controller using "otg-controller" property.
>>>>>>>> - ehci1 and ohci1: No "otg-controller" property.
>>>>>>>> - ehci2 and ohci2: No "otg-controller" property.
>>>>>>>>
>>>>>>>> In this environment, all hosts works correctly.
>>>>>>>> Also I think if we have 2 otg controlelrs, it should be work because otg_dev instance differs.
>>>>>>>
>>>>>>> The topic is about more than one otg controllers and how to tie the right ehci and ohci
>>>>>>> to the correct otg_dev instance especially in cases where we can't depend on probe order.
>>>>>>>
>>>>>>>> Or, does this topic assume an otg controller handles 2 EHCI controllers?
>>>>>>>> I'm not sure such environment actually exists.
>>>>>>>
>>>>>>> No it is not about that.
>>>>>
>>>>> Thank you for the reply. I understood it.
>>>>>
>>>>>>>>>> Alan, does USB core even know which EHCI and OHCI are linked to the same port
>>>>>>>>>> or the handoff is software transparent?
>>>>>>>>>
>>>>>>>>> The core knows.  It doesn't use the information for a whole lot of
>>>>>>>>> things, but it does use it in a couple of places.  Search for
>>>>>>>>> "companion" in core/hcd-pci.c and you'll see.
>>>>>>>>
>>>>>>>> Thank you for the information. I didn't know this code.
>>>>>>>> If my understanding is correct, the core/hcd-pci.c code will not be used by non-PCI devices.
>>>>>>>
>>>>>>> That is correct.
>>>>>>>
>>>>>>>> In other words, nobody sets "hcd->self.hs_companion" if we use such a device.
>>>>>>>> So, I will try to add such a code if needed.
>>>>>>>
>>>>>>> I think OTG core would have to rely on USB core in providing the right companion device,
>>>>>>> just like we rely on it for the primary vs shared HCD case.
>>>>>>>
>>>>>>
>>>>>> OK, it is not so simple.
>>>>>>
>>>>>> EHCI and companion port handoff is really meant to be software transparent.
>>>>>>
>>>>>> non-PCI devices really don't have knowledge of which OHCI instance is companion to the EHCI.
>>>>>> With device tree we could provide this mapping but for non-device tree case we can't do
>>>>>> anything.
>>>>>>
>>>>>> So my suggestion would be to keep dual role implementation limited to one instance for
>>>>>> EHCI + companion case for non-DT.
>>>>>> For PCI case I don't see how dual role can be implemented. I don't think we have any
>>>>>> dual-role PCI cards.
>>>>>
>>>>> R-Car Gen2 SoCs (r8a779[0134] / arm32) has USB 2.0 host controllers via PCI bus and
>>>>> one high speed function controller via AXI bus.
>>>>> One of channel can be used as host or function.
>>>>>
>>>>>> For DT case we could have a DT binding to tie the EHCI and companion and use that
>>>>>> in the OTG framework.
>>>>
>>>> After looking at the code it seems we don't need this special binding as we are already
>>>> linking the EHCI controller and companion controller to the single otg controller instance
>>>> using the otg-controller property.
>>>>
> 
> [...]
>>>
>>> Then, how you know this EHCI + companion controller special case during otg adds
>>> hcd, it needs special handling, right?
>>
>> We know the special case by using the hcd_needs_companion flag.
>>
> 
> You had said "we don't need this..", ok, yes, we do need it.
> 
I'm sorry for the confusion. What I meant by "we don't need this special binding" was that
we don't need additional binding to link the HCD and companion HCD.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
