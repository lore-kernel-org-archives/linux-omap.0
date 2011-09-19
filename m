From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/5 v9] mfd: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Mon, 19 Sep 2011 19:31:23 +0530
Message-ID: <CAP05o4+AYs07JLio7NgSUOuzSTqiZA45WPDPqAB55u=02vHYWA@mail.gmail.com>
References: <1316092970-2440-1-git-send-email-keshava_mgowda@ti.com>
	<20110919135653.GR32263@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110919135653.GR32263@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, b-cousson-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 19, 2011 at 7:26 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> w=
rote:
> Hi Keshava,
>
> On Thu, Sep 15, 2011 at 06:52:45PM +0530, Keshava Munegowda wrote:
>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>
>> The Hwmod structures and Runtime PM features are implemented
>> For EHCI and OHCI drivers of OMAP3 and OMAP4.
>> The global suspend/resume of EHCI and OHCI
>> is validated on OMAP3430 sdp board with these patches.
>>
>> these patches are rebased to kevin's pm branch and
>> usbhs latest mainline kernel patches
>
> I'm ready to apply this one to my MFD for-next branch. Or do you want=
 it to go
> through Kevin's tree ?
>
> Cheers,
> Samuel


Thanks samuel;
But, patch 1 and 2 requires benoit causson's ack by;
so , I am waiting for benoit response on this.

please wait till I will cofirm for the merge; As of now, kevin and
balbi are OK with these patches,
benoit's confirmation/comments  are pending.

Thanks and regards
keshava




>
>
>> TODO:
>> =A0 =A0- Adding pad configurations to Hwmods
>> =A0 =A0- Aggressive clock cutting in usb bus suspends
>> =A0 =A0- Remote Wakeup implementation using irq-chaining
>>
>>
>> Benoit Cousson (1):
>> =A0 arm: omap: usb: ehci and ohci hwmod structures for omap4
>>
>> Keshava Munegowda (4):
>> =A0 arm: omap: usb: ehci and ohci hwmod structures for omap3
>> =A0 arm: omap: usb: register hwmods of usbhs
>> =A0 arm: omap: usb: device name change for the clk names of usbhs
>> =A0 mfd: omap: usb: Runtime PM support
>>
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 | =A0 26 +-
>> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 =A0 =A0 | =A0 10 +-
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | =A0281 +++++++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0247 ++++++++++
>> =A0arch/arm/mach-omap2/usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0114 +=
+---
>> =A0arch/arm/plat-omap/include/plat/usb.h =A0 =A0 =A0| =A0 =A03 -
>> =A0drivers/mfd/omap-usb-host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A07=
33 +++++++++++-----------------
>> =A0drivers/usb/host/ehci-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17=
 +-
>> =A0drivers/usb/host/ohci-omap3.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 18=
 +-
>> =A09 files changed, 891 insertions(+), 558 deletions(-)
>>
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
