From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] ARM: dts: n900: Rename isp1704 to isp1707 to match
 correct name
Date: Mon, 22 Feb 2016 11:06:50 -0800
Message-ID: <20160222190649.GR13417@atomide.com>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
 <1456054103-19551-7-git-send-email-pali.rohar@gmail.com>
 <20160221140517.GA25072@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160221140517.GA25072@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160221 06:05]:
> On Sun 2016-02-21 12:28:23, Pali Roh=C3=A1r wrote:
> > This change does not break existing userspace or Maemo software bec=
ause
> > isp1704_charger.c always export power supply device under isp1704 n=
ame.
>=20
> ..exports..
>=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> 4,5,6: Acked-by: Pavel Machek <pavel@ucw.cz>

Ack for this one to get merged along with the driver changes:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
