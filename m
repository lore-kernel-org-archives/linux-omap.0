From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 14/16] mfd: omap-usb-host: Support an auxiliary clock per
 port
Date: Wed, 21 Nov 2012 15:58:41 +0200
Message-ID: <20121121135841.GO10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-15-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVYOjVWOcH+Ezkzp"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352990054-14680-15-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nVYOjVWOcH+Ezkzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:12PM +0200, Roger Quadros wrote:
> Boards like Panda require an auxiliary clock to clock the PHY
> that is connected to one of the USB ports. This patch enables
> board support code to  provide the name and the rate of such
> a clock for each of the USB ports. omap-usb-host driver can
> then manage the clock.

that clock is part of the PHY. What we need is a proper PHY driver and
teach [ouex]hci-core about PHYs.

I'd rather this wasn't merged...

--=20
balbi

--nVYOjVWOcH+Ezkzp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrN4RAAoJEIaOsuA1yqRE6Y8P/jRZ1B8NCCo9erc3HOsr4S/m
HJfciMXVvj7RO6PKAXjeyP+gd6pd4NYM7gywPHxBZfltaA+oi6TZRYvCZM348uKU
xRA+QdEoiwXwlAulQgjaA2X6lpqclwmbRnE0DLA3kvdqjXlgCHUDTEOIr2HhU1l1
LJkeLOTBAYkVmz29smGmMGh7nN3Hp+WHmnG/09dHSBtDOK1g1YORuGdZSJukPJBy
8wFKEqZzGjRy4HQsuiAhaMAOEAHYmp+9+wPUXEBykvYojG9zl/rs7e7NRyoGO7OK
ikLcwcI/XQJHBqMw9H8njFqLueLFLDokSpZXLbLjMdvGF+bB3kA1vJLnd1wVf8av
aLYMbF35QfxYlHnE76+d14PKdHjCSZDHLVFX3fHkK0fU+myF1eCZl1HwUyajTvhz
Sv9wL+T98m/hi9Y9kHydCcqZjuM23Q2hSLYfDU5xXemxURX6tP1ZAunWTtzAibpF
YBYsSUel/Q+E5AvDJL0XWRpz6aTYYyMVhgbVQANDNDj28Qi2TUvm2XZnTHnsgCsA
mVXBrUxYNQA8D7Zzh+eDpKXYJbaQNZZn0uJXxcNIoHXzUDJe8FkWPL1k9ffT8Sd7
cIN9Owx/JT78eId9mfeY2cIChgkvFyakgiuhuanJGb3jc9KpWp2pEiy6aBhT2xMQ
qn0dK6jb4B5yIPTQTEua
=ouLH
-----END PGP SIGNATURE-----

--nVYOjVWOcH+Ezkzp--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
