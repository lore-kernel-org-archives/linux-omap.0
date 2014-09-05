From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3
 HC
Date: Fri, 5 Sep 2014 11:56:43 -0500
Message-ID: <20140905165642.GI24449@saruman.home>
References: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
 <1409931392-22340-2-git-send-email-peter.griffin@linaro.org>
 <20140905154700.GE24449@saruman.home>
 <20140905155321.GF24449@saruman.home>
 <20140905165520.GA25253@griffinp-ThinkPad-X1-Carbon-2nd>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140905165520.GA25253@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2014 at 05:55:20PM +0100, Peter Griffin wrote:
> Hi Felipe,
>=20
> On Fri, 05 Sep 2014, Felipe Balbi wrote:
> > > > +
> > > > +	device_for_each_child(&pdev->dev, NULL, st_dwc3_remove_child);
> > >=20
> > > same as before, of_platform_depopulate(). I can fix this one myself t=
his
> > > time.
>=20
> Oh sorry, not sure what happened there, thanks for fixing it up:-)

no problem, it was small enough

> > it's in my testign/next branch, please make sure it looks alright.
>=20
> Just checked and it looks good.

cool thanks, I'll run some extra build testing and move it to next
soonish.

--=20
balbi

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUCetKAAoJEIaOsuA1yqREP5wP/1n8vrT8LcwXIdpN0Cb+Y0Xm
upqsFNc2Rjz6+2XuU6qjlw6UAvdCMrkbknLrl6ctZ+6TsHc8dj5c5lDc00YMlTQT
v3wFS7txCnmMOyG0xILrlb8x5bxpoXB7P3Rj5MdZx4iPcpTd5/gCo+vQOm8iDASj
EgUVvy2eu32WPse/TxoNjs/McfiGrOy5kIEQprt52mLJHfw8ot2T5Llo5i3+8Y8W
JvrGs/aRDWkWxBeAhY9VufzPyT1A5WQ/GIaJo8QRLepDk6G3cYuCJMJMvUjSjQhn
qaA8wOHnE3+dv7FEboCxHrADKXFMEold1UaYE+0tcfx2U3ewxEwqXSpPAO3BJ8SU
PDV3uj12iSCY6zvAamseLGVKZjWjMcUKMWENyPaGqLr9J9pHwdo3SqpI+PTeYgkM
V6VrFlkckM3B+WmNPu6+UD98C/25EoR0Cy3UjoCNMdYr/G9IU/gEz6ZY5kA9mMih
wdy3Q9T4x9p+lHSVpMIznY/eFTsEz0HePxDI2zC0z90CVCZ3MemDO8e4+YQxY+Fg
bCuPLafwbQ338CCVbMX6Lm5uk0Xc3trWtw7LAi2ncTIiCTPRO0Q/rgsAUMfzhsnx
MkZjmnbq9CxkT8n7bzMZB7cJdbbkCH6ULTz5eGRIAx2n/0TuTSs7RUWzNtxfx6Ij
G30EkQCPYP8B2i9MybXs
=XG+P
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
