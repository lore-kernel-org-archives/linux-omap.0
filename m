From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 13/16] mfd: omap-usb-host: Get rid of unnecessary spinlock
Date: Wed, 21 Nov 2012 15:57:32 +0200
Message-ID: <20121121135732.GN10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-14-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJAv8lSwuaQsYd0G"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352990054-14680-14-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--oJAv8lSwuaQsYd0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 04:34:11PM +0200, Roger Quadros wrote:
> We don't really need a spinlock here, so get rid of it.

can you prove it ? what if an IRQ happens right after disabling clocks
on ->runtime_suspend() but before it returns ? Will this not cause a
problem for you ?

(note that I have not dug pm_runtime code to make sure this wouldn't
cause a race).

--=20
balbi

--oJAv8lSwuaQsYd0G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrN3MAAoJEIaOsuA1yqREBTkP/R6kezPrMhfhn863qDAfyx4t
Y5DfAzXmpTWV0jYEHGTtBz0iB/js43Ip1EkM2vsRTAdjuRMRV6/WRLsF8TxUCeUt
DXoR62Fi+nzVmo/k1cxxsg2ACGF6EyOkT1b5izhK7tLWD0JtF1X7ptRkyVeTIrmC
1MLKmcsKzATq2UmpuOWze3Van8iiw33mzV0KIZvs6Y9DRMP0Mo/zDkR+KVh1zMdH
y+vEOi+pFxBU+wZEuL2S69Bvv+NlPAet/hj3SNeUSj0oUryXD+eXgzl9X02uPAS2
g8+LXcaN7iYYnOIJ04OmLznfqn+iOSRU1kLxdjI+9PWwI7iEZXdPyg/LpbbeY4bY
BqWr3vnGcxippZFkSOaf6WmNmH4mXgPmJpWXIR3FfJ6PVgYvpGV8gM2+TOuA7Gxr
y5p1mx1WtDs6frA4k9VQY8tK97QQfYLKRoXxL1qMSr3IZHKWfig0A+XOKohfm1a9
to1Asg1dImzqkGRe2zHBoFiYTDDPNHK5l+v5MTUoAnyXZm0v0zgDXttX6tbwzqWM
BvpyAowctC8B7pyDME7a/Uaav83ccEb7R9yALENZvz3M1ZTHmSEDbehi91S8URFc
mLiGrRUMoKFDYmED6MJMMPWLkPIMd3KPWfprFxe1F9Jg826yqixgR9j5MDViWyFl
Rvno5E3BWgNT6ZjVBpcN
=ATju
-----END PGP SIGNATURE-----

--oJAv8lSwuaQsYd0G--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
