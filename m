From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 5/6] OMAP3: Serial: Made serial to work properly with
 PRCM chain handler
Date: Thu, 23 Jun 2011 04:12:29 -0700
Message-ID: <20110623111229.GB23145@atomide.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
 <1308760934-9757-6-git-send-email-t-kristo@ti.com>
 <20110623082150.GX23145@atomide.com>
 <1308820284.5972.18.camel@sokoban>
 <20110623100054.GA23145@atomide.com>
 <BANLkTin1u_tKN8mwM0xYhq=qjWkRfx8X2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61791 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758170Ab1FWLMe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 07:12:34 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin1u_tKN8mwM0xYhq=qjWkRfx8X2Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org

* Govindraj <govindraj.ti@gmail.com> [110623 03:30]:
> On Thu, Jun 23, 2011 at 3:30 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Tero Kristo <t-kristo@ti.com> [110623 02:06]:
> >> On Thu, 2011-06-23 at 10:21 +0200, Tony Lindgren wrote:
> >> > * Tero Kristo <t-kristo@ti.com> [110622 09:38]:
> >> > > @@ -550,6 +550,8 @@ static void omap_uart_idle_init(struct oma=
p_uart_state *uart)
> >> > > =C2=A0 ret =3D request_threaded_irq(uart->irq, NULL, omap_uart=
_interrupt,
> >> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IRQF_SHARED, "serial idle", (=
void *)uart);
> >> > > =C2=A0 WARN_ON(ret);
> >> > > + ret =3D omap_prcm_register_pad_irq(uart->padconf, uart->irq)=
;
> >> > > + WARN_ON(ret);
> >> > > =C2=A0}
> >> >
> >> > Argh, looks like we still have direct mux register tinkering in =
serial.c:
> >> >
> >> > $ grep "padconf =3D 0x" serial.c
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 padconf =3D 0x182;
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 padconf =3D 0x17a;
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 padconf =3D 0x19e;
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 padconf =3D 0x0d2;
> >> >
> >> > By deducting 0x30 from the values above, these map into the foll=
owing mux defines:
> >> >
> >> > $ grep RX_OFFSET mux34xx.h
> >> > #define OMAP3_CONTROL_PADCONF_UART2_RX_OFFSET =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x14a
> >> > #define OMAP3_CONTROL_PADCONF_UART1_RX_OFFSET =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x152
> >> > #define OMAP3_CONTROL_PADCONF_UART3_RX_IRRX_OFFSET =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x16e
> >> >
> >> > So you can make things more generic by getting rid of those and =
using
> >> > struct omap_mux_partition instead for omap_prcm_register_pad_irq=
=2E
> >> > The pins used are set already in serial.c with omap_hwmod_mux_in=
it.
> >> >
> >> > Otherwise we have to patch the hardcoded padconf values for ever=
y new omap.
> >> > And looks like we're already missing them for 44xx in serial.c.
> >> >
> >> > Then access to the padconf registers should be done with
> >> > omap_mux_read/write instead. If you need to do something more co=
mplex
> >> > with them maybe consider adding some new functions to mux.c as n=
eeded.
> >> >
> >>
> >> Padconf stuff is not that much related to this patch set yet (I am=
 not
> >> touching the serial padconf code), but I can probably take a look =
at
> >> this also later on, unless you want this fixed with this set alrea=
dy?
> >
> > Yes please, maybe make it a separate patch before your series to
> > prepare things?
> >
> > Otherwise we will have to change the omap_prcm_register_pad_irq
> > later on in each driver using it.
> >
>=20
> Agree,
> I am planning of use this call from omap-serial driver. :)
>=20
> How about using omap_hwmod_mux_get_wake_status proposed earlier?
>=20
> https://patchwork.kernel.org/patch/773932/

Hmm, usually there's only one wake-up enabled pin though. Do we
ever have more than one per device? If not, there's no need  to
iterate over the list every time.
=20
> How about register with omap_hwmod data and irq_number from driver
> after requesting irq ?
>=20
> I suppose even using omap_hwmod data from driver file not allowed.
> or use pdev ?

Eventually the configured pins come from device tree and then hwmod
code can set up things automagically for the device. I think drivers
should just use device_set_wakeup_enable to set it and then the wake-up
capability should change automatically somehow.. Or maybe I did not
quite understand what you're after.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
