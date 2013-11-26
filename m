From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/4] usb: musb: dsps: add support for suspend and
 resume
Date: Tue, 26 Nov 2013 09:57:38 -0600
Message-ID: <20131126155738.GD24310@saruman.home>
References: <1385414803-13212-1-git-send-email-zonque@gmail.com>
 <1385414803-13212-5-git-send-email-zonque@gmail.com>
 <20131125212920.GU18046@saruman.home>
 <5293C17D.3020508@gmail.com>
 <20131125213236.GW18046@saruman.home>
 <52949460.6090708@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52949460.6090708-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 01:30:24PM +0100, Daniel Mack wrote:
> On 11/25/2013 10:32 PM, Felipe Balbi wrote:
> > On Mon, Nov 25, 2013 at 10:30:37PM +0100, Daniel Mack wrote:
> >> On 11/25/2013 10:29 PM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Mon, Nov 25, 2013 at 10:26:43PM +0100, Daniel Mack wrote:
> >>>> +static int dsps_resume(struct device *dev)
> >>>> +{
> >>>> +	struct dsps_glue *glue =3D dev_get_drvdata(dev);
> >>>> +	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
> >>>> +	struct musb *musb =3D platform_get_drvdata(glue->musb);
> >>>> +	void __iomem *mbase =3D musb->ctrl_base;
> >>>> +
> >>>> +	dsps_writel(mbase, wrp->control, glue->context.control);
> >>>> +	dsps_writel(mbase, wrp->epintr_set, glue->context.epintr);
> >>>> +	dsps_writel(mbase, wrp->coreintr_set, glue->context.coreintr);
> >>>> +	dsps_writel(mbase, wrp->phy_utmi, glue->context.phy_utmi);
> >>>> +	dsps_writel(mbase, wrp->mode, glue->context.mode);
> >>>> +	dsps_writel(mbase, wrp->tx_mode, glue->context.tx_mode);
> >>>> +	dsps_writel(mbase, wrp->rx_mode, glue->context.rx_mode);
> >>>> +
> >>>> +	//musb_port_reset(musb, false);
> >>>
> >>> ????
> >>>
> >>
> >> Urgs. Development left-over. Sorry. You want me to resend the whole
> >> series or just this last patch?
> >=20
> > just the last patch is fine :-)
>=20
> Sorry, there was one more hunk that shouldn't be there. I'll resend a v4
> with all the patches included again, for reference.

ok, thanks :-)

--=20
balbi

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlMTyAAoJEIaOsuA1yqRE8EAQAK1Kuo0qwwO163KhJWEFvGGX
k0TkX1lSTFkqlJ1jmppOBbHyL/aNP+jopCp93xKYshxQI9/H/8WJsBUIPlnzliOP
cT80TNf3HkDQ4I52hz9wLj586NuerFgRuQ+wfsJGExa0fm1S69m9QDgGr1QlzMBh
brvTrGoffIpz3BbJBe0hhukvkaPKolg91NurODDiTATr3CJRrDagYSIDAEy9Lzvo
3aEOx7RsT6BARDra0GrH9KDxMsRkjsMz+IyQMlyj7VEK83bj8QbFah4lM+ThSUFG
3c92BrudkrkQPq0pS2tfxcPB+g8/4YBSOg5spf2L/9FD0QiDm8nrUFvW4n86G2yp
vcJ+6En5SySimAK8FQlP2OI/EZNT94cjusjKm4rFBE79x5PsSlvGw/HXSkg+UFY1
YFWUqk3rlWv98vvpUs+5YFKPB5i1tWjF+3s7zMshuO6uv/VKDoaJI4LhN5MgAL2f
JWXRtqV8RHQ258mpUXNPmOl5e93aDr5ZPgCLenVGkYvQCRbaWC/FjEE4laHTEBIK
s+hVO/ZQ+R9a2Iu268OBBgLJwteq+GH8gaY2nrkKRbj66WbjoH03TR+bU+ovhJul
6MGRt2qLOhdzPpu589cb5uK+/8oYOb1CbjRRBBZMRXHFZGmSekeLzVAGQtWDx09o
Eo8fXWzbFHuCQtHCLJyU
=kcJW
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
