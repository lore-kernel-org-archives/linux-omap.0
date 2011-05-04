From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 07/12] OMAP: Serial: Allow UART parameters to be
 configured from board file
Date: Wed, 4 May 2011 03:25:43 -0700
Message-ID: <20110504102543.GB2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-8-git-send-email-govindraj.raja@ti.com>
 <20110504095546.GY2092@atomide.com>
 <BANLkTimb-AsuXYRm+NV8CD3m=xHwteV7pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13400 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753262Ab1EDKZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 06:25:48 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimb-AsuXYRm+NV8CD3m=xHwteV7pw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Deepak K <deepak.k@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Jon Hunter <jon-hunter@ti.com>

* Govindraj <govindraj.ti@gmail.com> [110504 03:03]:
> On Wed, May 4, 2011 at 3:25 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
> > * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
> >> @@ -250,7 +251,7 @@ static void __init omap_2430sdp_init(void)
> >> =C2=A0 =C2=A0 =C2=A0 omap2430_i2c_init();
> >>
> >> =C2=A0 =C2=A0 =C2=A0 platform_add_devices(sdp2430_devices, ARRAY_S=
IZE(sdp2430_devices));
> >> - =C2=A0 =C2=A0 omap_serial_init();
> >> + =C2=A0 =C2=A0 omap_serial_init(NULL);
> >> =C2=A0 =C2=A0 =C2=A0 omap2_hsmmc_init(mmc);
> >> =C2=A0 =C2=A0 =C2=A0 omap2_usbfs_init(&sdp2430_usb_config);
> > ...
> >
> >> =C2=A0static inline void board_serial_init(void)
> >> =C2=A0{
> >> - =C2=A0 =C2=A0 omap_serial_init();
> >> + =C2=A0 =C2=A0 omap_serial_init(NULL);
> >> =C2=A0}
> >
> > This change seems like "crazy churn" and probably not needed
> > if it's always null. Boards using platform_data can use
> > omap_serial_init_port instead, right?
>=20
> We can intiliaze only one uart port with omap_serial_init_port.
>=20
> omap_serial_init initializes all uart port.
>=20
> During any client device integration using dma mode
> (for example Bluetooth) we can pass the dma config
> params based on the board & client device.

But you're changing all omap_serial_init() calls to
omap_serial_init(NULL) so there are no users for that.

It should be a separate patch if it's needed.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
