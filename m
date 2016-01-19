From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Tue, 19 Jan 2016 12:33:15 -0800
Message-ID: <20160119203314.GE19432@atomide.com>
References: <201601091616.04193@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201601091616.04193@pali>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160109 07:16]:
> Hello,
>=20
> when I boot 4.4.0-rc7+ kernel compiled with g_nokia into zImage on No=
kia=20
> N900 into userspace then usb gadget (g_nokia) does not work. Notebook=
,=20
> connected on other side does not see any usb device... Connecting and=
=20
> disconnecting cable does not change anything, still not work.
>=20
> But if I run this command
> $ echo peripheral > /sys/bus/platform/devices/musb-hdrc.0.auto/mode=20

=00
>=20
> then gadget starts working. Other side see usb device and can use it.=
=20
> Also connecting and disconnecting usb cable working fine. After=20
> connecting it again, usb device OK.

N900 had the PHY interrupt wired to the bq chip instead of twl4030, rig=
ht?

You can fix this issue similar to phy-twl4030-usb.c. In function
twl4030_phy_power_on() we call schedule_delayed_work() that checks
the state of the ID pin on boot up.

I think that's only needed for the i2c based PHY's with MUSB, with
the others the USB driver has a better idea of the current state.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
