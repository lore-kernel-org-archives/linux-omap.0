From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
Date: Mon, 6 Aug 2012 12:44:02 +0300
Message-ID: <20120806094401.GI17551@arwen.pp.htv.fi>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-2-git-send-email-kishon@ti.com>
 <20120803132708.GC8269@arwen.pp.htv.fi>
 <CAAe_U6K15Nm5aNs2Vn71G7ELZWka1zB2E3VGZWTc0VjyViJ6Yw@mail.gmail.com>
 <20120806084928.GD17551@arwen.pp.htv.fi>
 <CAAe_U6LhfrRk7PP-Td7BTXPngo7+chvTp4LwwKR_GbsjE4jNJQ@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UthUFkbMtH2ceUK2"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAe_U6LhfrRk7PP-Td7BTXPngo7+chvTp4LwwKR_GbsjE4jNJQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--UthUFkbMtH2ceUK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2012 at 03:14:42PM +0530, ABRAHAM, KISHON VIJAY wrote:
> >> >> +static int omap_usb2_runtime_resume(struct device *dev)
> >> >> +{
> >> >> +     u32 ret =3D 0;
> >> >> +     struct platform_device  *pdev =3D to_platform_device(dev);
> >> >> +     struct omap_usb *phy =3D platform_get_drvdata(pdev);
> >> >> +
> >> >> +     ret =3D clk_enable(phy->wkupclk);
> >> >> +     if (ret < 0)
> >> >> +             dev_err(phy->dev, "Failed to enable wkupclk %d\n", re=
t);
> >> >> +
> >> >> +     return ret;
> >> >> +}
> >> >> +
> >> >> +static const struct dev_pm_ops omap_usb2_pm_ops =3D {
> >> >> +     SET_RUNTIME_PM_OPS(omap_usb2_runtime_suspend, omap_usb2_runti=
me_resume,
> >> >> +             NULL)
> >> >
> >> > only runtime ? What about static suspend ? We need this to work also
> >> > after a traditional echo mem > /sys/power/state ;-)
> >>
> >> The static suspend case is handled by users of this phy using
> >> set_suspend hooks.
> >
> > I'm not sure if that's too wise, what if your user enabled USB, but
> > for whatever reason loaded only the phy driver and not musb or dwc3. It
> > will fail, right ?
>=20
> The enabling and disabling of phy is solely governed by usb controller
> driver (musb/dwc3). So if you dont have musb/dwc3 loaded, the phy will
> be for sure disabled.

fair enough... that's ok then ;-)

--=20
balbi

--UthUFkbMtH2ceUK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQH5HhAAoJEIaOsuA1yqREFAYP/0Tg9jYi+w6+3EISdUAnuQXj
g8RJET/C2H72vx/2MS7PbqLhNb22pAw1+NrEB1hq3z450DTln+yRg0xVsYL7/OkQ
qLrW4ARCG7CUd54n1gDPuIlOkH1qpcNxenpJfxxOuTbs+vejXWBulBzoRfbFZySy
uh8GA3mFOvrBqmkeWhNlPQ2qoWhETEXgxqkmylX0FSW67arB/qWvkwVuPuGv/O70
y1MnXvUPeoYUVRm30m8TKzFMWrX58A5YqfPuwEmuOhziJpHT0lUKxL3xJhDD//qZ
zD9P4D5KXKnx23ruFlfRCdfFMs8SNPRTgQvdTr9gQnM+U0eaHUQFSRFiVYZHHdB0
EQZPqWp0qUhAGAJendrDXhfPjaUo8cyvVFdWx4uOAkObn5AutP2s+FOZIF6HmGg8
ewAmRcB4uKgeG9DNiVyfhCh3s3C7nLMgAn9/adQFmfXRK3Z+bos4Hr1BJ9+RXAL1
2o0imPpz2x7fucPoXoQBYoKJME+29d5slCfpK42ypHo9CS8Q/yUaxmSS1DUhpTmM
Y5T0pGNmHHXnZAHT2vdR31OaUnMpMFgGA1jk/76grdnA62eAEgtEXp4A7TqAzL14
6HQahuxXnPZuoDH/WZJtvVOpEDdFI/MuCJVw0t8dM2U7bgjQD0ep7U94TNFSVm6N
kiZ5+IO93rKVrF0oxTCv
=nEBC
-----END PGP SIGNATURE-----

--UthUFkbMtH2ceUK2--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
