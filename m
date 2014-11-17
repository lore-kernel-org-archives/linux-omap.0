From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Mon, 17 Nov 2014 07:06:17 -0800
Message-ID: <20141117150617.GD7046@atomide.com>
References: <20141116075928.GA9763@amd>
 <20141117101553.GA21151@amd>
 <20141117145545.GC7046@atomide.com>
 <201411171601.32311@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201411171601.32311@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sakari.ailus@iki.fi, devicetree@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141117 07:03]:
> On Monday 17 November 2014 15:55:46 Tony Lindgren wrote:
> >=20
> > There's nothing stopping us from initializing the camera code
> > from pdata-quirks.c for now to keep it working. Certainly the
> > binding should be added to the driver, but that removes a
> > dependency to the legacy booting mode if things are otherwise
> > working.
>=20
> Tony, legacy board code for n900 is not in mainline tree. And=20
> that omap3 camera subsystem for n900 is broken since 3.5=20
> kernel... (both Front and Back camera on n900 show only green=20
> picture).

I'm still seeing the legacy board code for n900 in mainline tree :)
It's deprecated, but still there.

Are you maybe talking about some other piece of platform_data that's
no longer in the mainline kernel?

No idea what might be wrong with the camera though.

Regards,

Tony
