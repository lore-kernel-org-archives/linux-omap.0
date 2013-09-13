From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: display: Create omapdrm inside omap_display_init
Date: Fri, 13 Sep 2013 12:42:07 +0300
Message-ID: <5232DDEF.60401@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379063679-4869-2-git-send-email-archit@ti.com> <5232D9C8.9020809@ti.com> <5232DCFE.5050700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lL7KI7IpoHvw7eA1Hpna7Uk3F9iBVdwF3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5232DCFE.5050700-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--lL7KI7IpoHvw7eA1Hpna7Uk3F9iBVdwF3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 12:38, Archit Taneja wrote:

>> Also, omapfb device is currently created the same way as omapdrm,
>> independently of omapdss. Why is it a problem to have them like that?
>=20
> In a multiplatform config, we might have CONFIG_DRM_OMAP and
> CONFIG_DRM_OMAP_MODULE selected.
>=20
> This would cause the call omap_init_drm() in arch/arm/mach-omap2/drm.c
> to occur. Creating a platform device for omapdrm is unnecessary here
> isn't it? Tying it with the initialisation of omapdss devices prevents =
it.

Well, omapdrm depends on omapdss in Kconfig. So if you have DRM enabled,
you also have DSS enabled.

 Tomi



--lL7KI7IpoHvw7eA1Hpna7Uk3F9iBVdwF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSMt3vAAoJEPo9qoy8lh71hpwQAJUIUsaAgVQXr1bB9aHksr0t
V3Q8To4BMra4zqsk8/UZIImjFOnKqIGmCzgNUTG55ORP0gMe0SeLEulCJAaCZ/sA
FK7JxOyg+vAs7yPrqsU0+S5rHsxOJ2/QobIm6UlLUokPmUT3PFRCPMqzibDBFX/x
m9EnhS/HAbhHiURAb+VJb4FyOERvS9ER4M6XHCXfORLJxGb11n5jJjeFI6Tl9YzN
I7/I/cOnxkh+9+/WRElg2u6RXfQLaH5YFqlCL+o6BiInjMUw/4T/2LlbW8otG3Yq
wj53xwgR+XC/Q25IGIcO9UbfPx8JuwMeC6jsnt5OkPG+FzJKd+KcPHWA/2RVohOn
ZXvOgPeFgbXCO+Rx/2pRhiuikeUvYE6gVY7oUwNqovehiWuqxGomKTIygmJVeTqh
YeYBUBG5UPJfTyCPkhCw8KzjOmqIAz0E8a0vWt9Kjvcf4lkDWCH5xVmiLOI5wkcK
rPk7mj/jUbRgfe+eNNYzNXAiaXkG9wiYUHujWRoLqOjppY1jzIKzSH6BbG/vJLx5
zPkZr6GIvrhSCvRBDBCsD6eYczWpo4zfEgyTh7UKhoyZ3LuShSjnlmYtRPiBrDxC
Tp/AcFxoAB7Xal1b8cum3IXK+UWYKccpgsgkXMuB1wYOo5Uh9Mcx98hJ5TRlhBvw
4Gf+MGRlJR54qfpEnaa0
=DlbO
-----END PGP SIGNATURE-----

--lL7KI7IpoHvw7eA1Hpna7Uk3F9iBVdwF3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
