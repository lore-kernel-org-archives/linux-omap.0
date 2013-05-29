From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] usb: musb: fix clock naming
Date: Wed, 29 May 2013 20:41:44 +0300
Message-ID: <20130529174144.GE21290@arwen.pp.htv.fi>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
 <20130528173637.GE15794@arwen.pp.htv.fi>
 <CAGm1_ks7Y8n1xKA=qiCCFcxgydRiyeJS08A8TPnbnEEmkJxVyg@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGm1_ks7Y8n1xKA=qiCCFcxgydRiyeJS08A8TPnbnEEmkJxVyg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 12:06:52PM +0200, Yegor Yefremov wrote:
> On Tue, May 28, 2013 at 7:36 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wr=
ote:
> >> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> >>
> >> 'ick' was changed to 'hsotgusb_ick'
> >> 'fck' was changed to 'hsotgusb_fck'
> >>
> >> Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> >
> > NAK. Fix your clock data.
>=20
> Do you mean here arch/arm/mach-omap2/cclock3xxx_data.c?

yes

--=20
balbi

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRpj3YAAoJEIaOsuA1yqREWQ0P/3Lp3evSCT1poOb4XwM0xZqX
97k9vPLenCnGuGadmdMCqS0H2drUizcv3iDI3y+w+pbcb8uQw5l9ZF0rt9sxIqp3
NVTfV9LZQmlnOLgZJIS22im/Q531pty7hVJyzJwVYf3jXh+X5L2I0IGm4521kyOU
sYkf4ZroHl+z+gSkAuXNB6Wg4yLyISt2YHDLMf/bbhWWGYbqCexD2BSylRttndrF
2MsppbwmUKin+4rv1g8DoYoONRQZ/VRR6vWwGa/9s4DHugNM5WCtJKp4Mxnp2gFA
u31cD1z7IxbxgvxpZV4waJgh1Fai/DLhTQQ0EFoXfRhZtqUmVu8t59hwXd1VVoWO
jy9poGmB8PwHFnuUpGywvw0pxfMu/cZGlgeo6AX3NLa6NNdOEXVN5cjeoxaqALxc
B5bENg9bFULcprwlmtB8mZCK+JdXNvqXxfu2JONRW3OvRvVNNy/n7qx+YBOXsloA
Z9ksbk5osg9zuwcxir4KTaTRw4H+SxJjnkslJhNub9h3CqCDRi0Udj60QTd1gh1Y
3UxE5Aw5QpAAuQSqDOf36TjY9RXwujW1jYH2jhUJwVTuhJat1kz/Kq3k+qx3iQ8g
Rm82W+ol8ICuzwzisfuFB2Iwuhs4DpJTjdaU2fTUNsHMT9JyTA801pNPBsq3lGYy
Co7p/c8ziJmDHV1z1qJc
=WFMZ
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
