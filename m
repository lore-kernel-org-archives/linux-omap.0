From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC/PATCH 2/2] of: allow for boolean flags to have value
Date: Thu, 5 Feb 2015 19:39:14 +0100
Message-ID: <20150205183914.GV10842@pengutronix.de>
References: <1423159266-25561-1-git-send-email-balbi@ti.com>
 <1423159266-25561-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423159266-25561-2-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 05, 2015 at 12:01:06PM -0600, Felipe Balbi wrote:
> allowing values to boolean flags lets us setup
> defaults on DTSI which can get disabled later
> at board DTS if, for whatever reason, board can't
> use that default.
>=20
> One such example is DM81xx EVM where we can't use
> MUSB's multipoint feature even though SoC supports
> it. Something at the board level prevents us from
> using the feature.
>=20
> Instead of removing "multipoint;" from DTSI and
> adding it to all board DTS just so we can remove
> it from our quirky board seems like overkill when
> we could just add:
>=20
> 	multipoint =3D <0>;
>=20
> to that quirky board's DTS.
>=20
> Note that the description here is but one example
> and it's likely many others have faced something
> similar.
And others even came up with solutions, too: The right thing to do in
this case is

	/delete-property/ multipoint;

This works since

	cd296721a964 (dtc: import latest upstream dtc)

which is in 3.7-rc1. See

http://permalink.gmane.org/gmane.linux.drivers.devicetree/19170

for the related discussion.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
