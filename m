From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be
 configured from board file
Date: Wed, 2 Mar 2011 10:24:02 -0800
Message-ID: <20110302182402.GC20560@atomide.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
 <1298903958-6496-7-git-send-email-govindraj.raja@ti.com>
 <056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
 <AANLkTimD9rOC=4P6Vy2jzvcXZ-gZmF42Te4CBjS8AJLT@mail.gmail.com>
 <8ab9882cd92792e9bf2b836c0ec9c7fe@mail.gmail.com>
 <AANLkTi=MJigLvbJrRJ4CpyDcGd8sZXB7-1nFYup6EeDm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45887 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab1CBSYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 13:24:08 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=MJigLvbJrRJ4CpyDcGd8sZXB7-1nFYup6EeDm@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Sricharan R <r.sricharan@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Deepak Kattungal <deepak.k@ti.com>

* Govindraj <govindraj.ti@gmail.com> [110302 02:05]:
>
> >>>>+static struct omap_device_pad default_serial1_pads[] __initdata =
=3D {
> >>>>+ =C2=A0 =C2=A0 =C2=A0{
> >>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =3D=
 "uart2_rx.uart2_rx",
> >>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=A0=3D=
 OMAP_DEVICE_PAD_REMUX |
> > OMAP_DEVICE_PAD_WAKEUP,
> >>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.enable =3D OMA=
P_MUX_MODE0,
> >>>>+ =C2=A0 =C2=A0 =C2=A0},
=2E..

AFAIK you should only need the OMAP_DEVICE_PAD_REMUX option for
omap24xx. And if you use that option, you also need the .idle
value.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
