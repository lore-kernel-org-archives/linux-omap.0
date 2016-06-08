From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Wed, 8 Jun 2016 02:53:22 -0700
Message-ID: <20160608095321.GH22406@atomide.com>
References: <201601091616.04193@pali>
 <3690314.8jDXSUDcRZ@saturn>
 <20160121192113.GM19432@atomide.com>
 <201601231357.32629@pali>
 <20160529103824.GM29844@pali>
 <20160607125044.GI29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160607125044.GI29844@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: joerg Reisenweber <joerg@openmoko.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160607 05:53]:
> > Tony, what do you think about that patch?
> >=20
>=20
> Tony, PING

Yeah I don't know, AFAIK we don't have a generic way to
force MUSB to change mode without ID pin. If you have figured
something generic for that which does not actually tinker with
the PHY registers directly, that should be the generic
musb_set_mode() that we've been wondering about for years.

Maybe split the patches to the mode change and then the
sysfs entry fixes and repost to linux-usb and linux-omap
and make sure Bin as the new musb maintainer is included :)

The custom sysfs flags we should maintain support for naturally.

Regards,

Tony
