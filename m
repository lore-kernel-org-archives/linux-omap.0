From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] drivers: cleanup Kconfig stuff
Date: Tue, 2 Nov 2010 16:23:22 +0200
Message-ID: <AANLkTi=4hi-zNSFPvHnTEPeweTuqUwni+Aij_E6Zj8i5@mail.gmail.com>
References: <1288656853-4625-1-git-send-email-felipe.contreras@gmail.com>
	<1288656853-4625-3-git-send-email-felipe.contreras@gmail.com>
	<20101102141456.GV31158@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101102141456.GV31158-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Hao Wu <hao.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/11/2 Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> On Tue, Nov 02, 2010 at 02:14:13AM +0200, Felipe Contreras wrote:
>> Add missing dependencies, and remove redundant ones, and select sens=
ible
>> defaults.
>>
>> This is more user-friendly, and logical.
>>
>> =C2=A0- TWL4030_CORE people should be able to compile without ARM
>> =C2=A0- REGULATOR_TWL4030 if TWL4030_CORE and REGULATOR, it's pretty=
 clear we
>> =C2=A0 =C2=A0want this
>> =C2=A0- USB_GADGET_SELECTED is already inside USB_GADGET
>> =C2=A0- USB_GADGET_OMAP only works on ARCH_OMAP1, and USB_OTG_UTILS =
is
>> =C2=A0 =C2=A0already selected by NOP_USB_XCEIV
>> =C2=A0- USB_GADGET_R8A66597 is meant for ARCH_SHMOBILE
>> =C2=A0- USB_MUSB_HDRC needs either NOP_USB_XCEIV, or TWL4030_USB
>> =C2=A0- USB_MUSB_AM35X, NOP_USB_XCEIV is already selected because MA=
CH_OMAP3EVM
>>
>> Finally, move:
>> config USB_MUSB_HDRC
>> =C2=A0 =C2=A0 =C2=A0 select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_O=
MAP3EVM || BLACKFIN)
>> =C2=A0 =C2=A0 =C2=A0 select TWL4030_USB if MACH_OMAP_3430SDP
>>
>> To:
>> config TWL4030_USB
>> =C2=A0 =C2=A0 =C2=A0 default y if ARCH_OMAP3
>>
>> config NOP_USB_XCEIV
>> =C2=A0 =C2=A0 =C2=A0 default y if ARCH_DAVINCI || MACH_OMAP3EVM || B=
LACKFIN
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> All changes look fine to me, but I think you will need to split up th=
is
> patch for the different subsystem maintainers.

Ok, will do.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
