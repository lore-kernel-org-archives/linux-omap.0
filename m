From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] drivers: cleanup Kconfig stuff
Date: Tue, 2 Nov 2010 15:12:08 +0100
Message-ID: <20101102141208.GU31158@pengutronix.de>
References: <1288656853-4625-1-git-send-email-felipe.contreras@gmail.com> <1288656853-4625-3-git-send-email-felipe.contreras@gmail.com> <20101102131146.GA21476@opensource.wolfsonmicro.com> <AANLkTim6E+e=D88C8g+YDVwS1D5JPeXvVRw-JVoVxh2i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim6E+e=D88C8g+YDVwS1D5JPeXvVRw-JVoVxh2i-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Hao Wu <hao.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 02, 2010 at 04:02:18PM +0200, Felipe Contreras wrote:
> On Tue, Nov 2, 2010 at 3:11 PM, Mark Brown
> <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> > On Tue, Nov 02, 2010 at 02:14:13AM +0200, Felipe Contreras wrote:
> >
> >> =A0config REGULATOR_TWL4030
> >> =A0 =A0 =A0 bool "TI TWL4030/TWL5030/TWL6030/TPS695x0 PMIC"
> >> =A0 =A0 =A0 depends on TWL4030_CORE
> >> + =A0 =A0 default y
> >> =A0 =A0 =A0 help
> >> =A0 =A0 =A0 =A0 This driver supports the voltage regulators provid=
ed by
> >> =A0 =A0 =A0 =A0 this family of companion chips.
> >
> > This default is not suitable for non-OMAP platforms, it should be
> > conditional on OMAP or something if we're going to do this (though
> > generally we handle this with defconfigs rather than in Kconfig).
>=20
> This would only be enabled when TWL4030_CORE is enabled, so non-OMAP
> platforms would not get affected.
Well, all platforms that have TWL4030_CORE will get REGULATOR_TWL4030 b=
y
default, too.  (TWL4030_CORE doesn't depend on something omapish.)

=46or me this looks OK.  It would be still better if it removed
CONFIG_REGULATOR_TWL4030=3Dy from arch/arm/configs/omap2plus_defconfig.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
