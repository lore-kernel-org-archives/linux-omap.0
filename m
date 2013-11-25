From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/5] usb: musb: dsps: add support for suspend and resume
Date: Mon, 25 Nov 2013 14:08:53 -0600
Message-ID: <20131125200853.GG18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-5-git-send-email-zonque@gmail.com>
 <20131125194804.GB18046@saruman.home>
 <5293AD40.6060607@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3iqGNvuhWAyawlAA"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5293AD40.6060607-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--3iqGNvuhWAyawlAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 09:04:16PM +0100, Daniel Mack wrote:
> >> diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_v=
irthub.c
> >> index e977441..24e46c0 100644
> >> --- a/drivers/usb/musb/musb_virthub.c
> >> +++ b/drivers/usb/musb/musb_virthub.c
> >> @@ -109,7 +109,7 @@ void musb_port_suspend(struct musb *musb, bool do_=
suspend)
> >>  	}
> >>  }
> >> =20
> >> -static void musb_port_reset(struct musb *musb, bool do_reset)
> >> +void musb_port_reset(struct musb *musb, bool do_reset)
> >=20
> > NAK, this should not be called from the glue layers at all. If anything
> > call from musb_core's resume callback. That will only be called after
> > parent's resume has been called anyway.
>=20
> Given that this driver is successfully used with suspend/resume on other
> platforms without that reset, but it's clearly needed for dsps, I'm
> fairly sure this should be a glue-layer specific thing. Hence the change.
>=20
> I think it'll break things on other platforms if we unconditionally
> reset the port after resume, but I can't test it. Anyone?

your original commit log only says "we need to issue port reset" but it
never explains why. It could very well be you just found a device which
needs to be reset when coming out of suspend and it misses a quirk flag ?

In any case, those functions should never be called by the glue, if
reset needs to be called, it must be called by musb-hdrc.ko, if you need
a flag, pass a flag but I need a really good explanation in your commit
log of why that's necessary.

--=20
balbi

--3iqGNvuhWAyawlAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk65VAAoJEIaOsuA1yqREJH0P/1xzM1TtPRUwO95etM/kdnra
fjMHiJ88Mn1lhCUGlOAtY4794z2OerdUgBr7Ud1T1WZ513a0wB1tq5o2DsVhsR9m
EQwimFxOm6tsHVKJ14wqnaXoD9dWM0TrVHgQeOQR5tI5/YUkuB9JPYFJG3bq40vk
N6HotyE/SvScDatWjBsxh1ixgZuqPslwFkzg8pAbBeUkUcmSWhe2OvSRstPEKPpY
lMmfCz62HCYCjOJC4gjZ8nZiwSnTueO0JV40f0H5sYClzGqOv8CNKjMp6e/S/JJq
OgWDzsh+5HivehdpjJdJhtmx/7gDymvylQpVen4Jei+qv6u4HYJ+tW98qIqvFsyp
eO1PuDXrVPIfstR+sWjCDRGftKMl4pyjZiGIuKZazpPRJ+fuzU7QZSG4xX6CxmGO
LRsBBItt/X6gDZx4TjY57jampX8qqp7OlRN9hHj2v16l+ZFX+0eNPYwyI97GVnIG
2ob4xFQpTuln6doJ8yW8Lgoc9QyzVFRyqDMEKDA/Y7zzO5gL/wnUCrkITQcIP0Ms
IJ9E5LMGl1KzCvLl+yTsmctF1EsddWcAyGP01fTfzMEpTUVvyubhujJ29/EuWGR+
cmzYIvEk8QeWeBp6Z0c0n2mY9ubLx7OvBvhhAnPWVhRWB7vwKjMvxu0mPGR/CxPq
iysSy9Z9yBrnMC41TDzG
=G5x2
-----END PGP SIGNATURE-----

--3iqGNvuhWAyawlAA--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
