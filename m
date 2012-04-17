From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Tue, 17 Apr 2012 10:47:52 -0700
Message-ID: <20120417174752.GD21106@atomide.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-3-git-send-email-govindraj.raja@ti.com>
 <20120410161136.GF6487@atomide.com>
 <CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com>
 <20120417014103.GA21106@atomide.com>
 <CAMrsUd+v-qhVPLbJp1ecE2+e5ayJAQrAzALr1sviH9RDJv3aMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48886 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab2DQRr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 13:47:56 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUd+v-qhVPLbJp1ecE2+e5ayJAQrAzALr1sviH9RDJv3aMg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>

* Raja, Govindraj <govindraj.raja@ti.com> [120417 05:51]:
> On Tue, Apr 17, 2012 at 7:11 AM, Tony Lindgren <tony@atomide.com> wro=
te:
> > Hi,
> >
> > Few more comments below.
> >
> > * Raja, Govindraj <govindraj.raja@ti.com> [120411 04:53]:
> > ...
> >
> >> +static int =C2=A0__init omap_serial_fill_default_pads(struct omap=
_board_data *bdata,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct omap_uart_state *uart)
> >> +{
> >> + =C2=A0 =C2=A0 struct omap_mux_partition *tx_partition =3D NULL, =
*rx_partition =3D NULL;
> >> + =C2=A0 =C2=A0 struct omap_mux *rx_mux =3D NULL, *tx_mux =3D NULL=
;
> >> + =C2=A0 =C2=A0 char *rx_fmt, *tx_fmt;
> >> + =C2=A0 =C2=A0 int uart_nr =3D bdata->id + 1;
> >> +
> >> + =C2=A0 =C2=A0 if (bdata->id !=3D 2) {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_fmt =3D "uart%d_rx.=
uart%d_rx";
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_fmt =3D "uart%d_tx.=
uart%d_tx";
> >> + =C2=A0 =C2=A0 } else {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_fmt =3D "uart%d_rx_=
irrx.uart%d_rx_irrx";
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_fmt =3D "uart%d_tx_=
irtx.uart%d_tx_irtx";
> >> + =C2=A0 =C2=A0 }
> >> +
> >> + =C2=A0 =C2=A0 snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_L=
EN, rx_fmt,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uart_nr, uart_nr);
> >> + =C2=A0 =C2=A0 snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_L=
EN, tx_fmt,
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uart_nr, uart_nr);
> >
> > This naming won't work for the fourth port on 3630 as there are no =
"uart4_rx"
> > or "uart4_tx" mux entries, they are "gpmc_wait2.uart4_tx" and
> > "gpmc_wait3.uart4_tx".
>=20
> But uart4 is unused on 3630 boards and boards trying to use them
> should configure them from board file.
> (I thought we agreed on this approach where only if uarts are
> available in mux mode0 those ports will be dynamically muxed for wake=
up
> others should use omap_serial_init_port)
=20
Right, but you're still trying to do mux_get_by_name on it to check
the pads, which will produce a warning on 3630.

> >> @@ -289,8 +354,8 @@ void __init omap_serial_board_init(struct
> >> omap_uart_port_info *info)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bdata.pads =3D NU=
LL;
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bdata.pads_cnt =3D=
 0;
> >>
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap44xx() =
|| cpu_is_omap34xx())
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 omap_serial_fill_default_pads(&bdata);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (omap_serial_fill_d=
efault_pads(&bdata, uart))
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
> >>
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!info)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 omap_serial_init_port(&bdata, NULL);
> >
> > Can't the omap_serial_board_init() now be just be omap_serial_init(=
void)
> > as it's not used anywhere else?
>=20
> Yes sure we can remove that.

OK=20

> > Anyways, this is getting too complex for the -rc series as at least=
 2430sdp
> > is using alternative pins for the first uart. Let's patch to remove=
 just
> > the uart4 entry for 3630 for the -rc and then we can properly fix t=
his
> > for the next merge window.
>=20
> Okay. in that case the earlier patch [1] should be fine to solve the
> gpmc issue observed and ehci issue on beagle-xm.

I'll just use your first patch to remove _all_ the muxing for omap_seri=
al_init().
That's really the only safe thing we can do for the -rc cycle.

This means we rely on bootloader settings for console muxing and wake-u=
p
bits, but that's just what we need to live with until next merge window=
=2E

And for the next merge window, I think we should only automatically ena=
ble
the wake-up event bits if the port is in serial mode, and not do any ot=
her
muxing. Something like:

void __init omap_serial_init(void)
{
        struct omap_uart_state *uart;
        struct omap_board_data bdata;

        list_for_each_entry(uart, &uart_list, node) {
                bdata.id =3D uart->num;
                bdata.flags =3D 0;
                bdata.pads =3D NULL;
                bdata.pads_cnt =3D 0;
                omap_serial_check_wakeup(&bdata);
                omap_serial_init_port(&bdata, NULL);
        }

        omap_serial_board_init(NULL);
}

Where omap_serial_check_wakeup() just enables the wake-up if the
port is already muxed to uart mode. So it turns out we can't bail
out for unmuxed uarts because some boards use alternative pads like
2430sdp does for the first uart.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
