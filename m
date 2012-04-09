From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default
 pads
Date: Mon, 9 Apr 2012 13:36:51 -0700
Message-ID: <20120409203651.GB6487@atomide.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com>
 <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com>
 <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
 <20120406181556.GC15734@atomide.com>
 <CAMrsUdKs21qtrWX0i44fvm7U2JW0L=2NgmZBHAZGmwp03XFm6w@mail.gmail.com>
 <CA+Bv8XZgKg-Om9S=CcJEDWRan0pMZ_t1aCVT31q3REmcgLntBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30709 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2DIUgz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 16:36:55 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8XZgKg-Om9S=CcJEDWRan0pMZ_t1aCVT31q3REmcgLntBw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>

* Russ Dill <russ.dill@gmail.com> [120409 09:59]:
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> > Date: Mon, 9 Apr 2012 15:16:52 +0530
> > Subject: [PATCH] ARM: OMAP2+: UART: Fix usage of default uart pads.

> > -static int __init
> > +int __init
> > =C2=A0omap_mux_get_by_name(const char *muxname,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct omap_mux_partition **found_partition,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct omap_mux **found_mux)

This can now be one one line:

int __init omap_mux_get_by_name(const char *muxname,
=2E..


> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 tx_mode, rx_=
mode;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_mode =3D omap=
_mux_read(tx_partition, tx_mux->reg_offset);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_mode =3D omap=
_mux_read(rx_partition, rx_mux->reg_offset);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(rx_mode & =
0x07) && !(tx_mode & 0x07)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_omap_uart_pads[0].name =3D rx_pad_name;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_omap_uart_pads[0].flags =C2=A0=3D
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OMAP_DEVICE_PAD_REMUX | OMAP_DEV=
ICE_PAD_WAKEUP;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_omap_uart_pads[0].enable =3D OMAP_PIN_INPUT |
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OMAP_MUX_MODE0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_omap_uart_pads[0].idle =3D OMAP_PIN_INPUT |
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OMAP_MUX_MODE0;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_omap_uart_pads[1].name =3D tx_pad_name;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_omap_uart_pads[1].enable =3D OMAP_PIN_OUTPUT |
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OMAP_MUX_MODE0;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bdata->pads =3D default_omap_uart_pads;
>=20
> You are assigning this variable to a structure on the stack.
>=20
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bdata->pads_cnt =3D ARRAY_SIZE(default_omap_uart_pads);

Also, maybe make that into a separate function with comments added that
we check that the default pins are muxed to uart rx and tx mode to star=
t
with. Otherwise it's a bit hard to figure out what's going on here.

Then please split it into two patches: First one removes all the unsafe
muxing, then the second one enables wake-up events for the ports alread=
y
in uart rx/tx mode.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
