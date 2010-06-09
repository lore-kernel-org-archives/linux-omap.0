From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
 3630
Date: Wed, 9 Jun 2010 17:28:01 +0300
Message-ID: <20100609142801.GK32208@atomide.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
 <871vcmq08s.fsf@deeprootsystems.com>
 <20100607100656.GE15515@atomide.com>
 <AANLkTikpHFyvk28hTm-jTk4wdJ0oldqyncaGH2slq6w4@mail.gmail.com>
 <AANLkTikS_f5UWDr8WYrHga_W8kIeTwUienx6K37LWF80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53305 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab0FIO2I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jun 2010 10:28:08 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikS_f5UWDr8WYrHga_W8kIeTwUienx6K37LWF80@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

* Govindraj <govindraj.ti@gmail.com> [100607 17:50]:
> On Mon, Jun 7, 2010 at 5:02 PM, Govindraj <govindraj.ti@gmail.com> wr=
ote:
> > On Mon, Jun 7, 2010 at 3:36 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
> >> * Kevin Hilman <khilman@deeprootsystems.com> [100604 18:30]:
> >>>
> >>> > + =C2=A0 w &=3D ~0x7;
> >>> > + =C2=A0 w |=3D OMAP_MUX_MODE2;
> >>> > + =C2=A0 omap_ctrl_writew(w, uart->padconf);
> >>
> >> Generic NAK for tinkering with the mux registers directly.
> >>
> >> Instead, Govindraj, please add omap_mux_request_signal() into mux.=
c:
> >>
> >> void __iomem * __init omap_mux_request_signal(char *muxname);
>=20
> Looking into mach-omap2/mux.c
>=20
> Wouldn't retrieving offset will be enough as i have to depend on
> again *_mux_* function call for remux which can have the offset and v=
al
> as parameter.

You call omap_mux_request_signal with the signal name, and get
the register address. Then you can just set it with readw/writew.
=20
> So I need to use  ""K15_24XX_UART3_TX" as name to retrieve
> UART3 offset if I am correct and traverse through the list doing an s=
trcmp
> on name to retrieve offset.
>=20
> In that case I dont find uart1/2/4 in list,
> Should that be added into the list?

No, that's the old mux code. You want to do something like

void __iomem *uart1_rx;

uart1_rx =3D omap_mux_request_signal("uart1_rx");
if (!uart1_rx)
	return -ENODEV;
=2E..

See the signal names in mux34xx.c and the TRM. Then omap2 and omap4
will work automatically once the mux code is ready for those.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
