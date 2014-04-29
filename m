From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/7] phy: omap-usb2: Use generic clock names "wkupclk"
 and "refclk"
Date: Tue, 29 Apr 2014 11:16:16 -0500
Message-ID: <20140429161616.GI633@saruman.home>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
 <1398693687-13967-4-git-send-email-rogerq@ti.com>
 <20140428160347.GG30292@saruman.home>
 <535F59CF.6050002@ti.com>
 <20140429161420.GH633@saruman.home>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140429161420.GH633-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2014 at 11:14:20AM -0500, Felipe Balbi wrote:
> On Tue, Apr 29, 2014 at 10:50:39AM +0300, Roger Quadros wrote:
> > +Nishant
> >=20
> > Hi,
> >=20
> > On 04/28/2014 07:03 PM, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > On Mon, Apr 28, 2014 at 05:01:23PM +0300, Roger Quadros wrote:
> > >> As clocks might be named differently on multiple platforms, use a ge=
neric
> > >> name in the driver and allow device tree node to specify the platform
> > >> specific clock name.
> > >>
> > >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > >> ---
> > >>  drivers/phy/phy-omap-usb2.c | 8 ++++----
> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2=
=2Ec
> > >> index a2205a8..fb5e515 100644
> > >> --- a/drivers/phy/phy-omap-usb2.c
> > >> +++ b/drivers/phy/phy-omap-usb2.c
> > >> @@ -275,16 +275,16 @@ static int omap_usb2_probe(struct platform_dev=
ice *pdev)
> > >>  	if (IS_ERR(phy_provider))
> > >>  		return PTR_ERR(phy_provider);
> > >> =20
> > >> -	phy->wkupclk =3D devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
> > >> +	phy->wkupclk =3D devm_clk_get(phy->dev, "wkupclk");
> > >=20
> > > doesn't this patch cause a regression ? I mean, you're changing the
> > > clock name before fixing DTS. Also, that DTS has been in a major vers=
ion
> > > of the kernel, so we need to maintain compatibility with it. How abou=
t:
> >=20
> > I'm changing the DTS in Patch 4, but I prefer to do it in this patch
> > to prevent synchronization issues in -next.
> >=20
> > About backward compatibility, I agree with you but at the same time I
> > don't think anyone using TI SoCs burns the DTB to ROM and needs
> > backward compatibility. We supply our BSPs/SDKs with the updated DTBs.
> > Do you feel strict backward compatibility is worth the effort for TI
> > specific blocks?
>=20
> dunno, but it would, at least, avoid "synchronization issues with
> linux-next" :-)

and the bisectability issue.

--=20
balbi

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTX9BQAAoJEIaOsuA1yqRELnIQAIySXKdEV2vM0oANNVKncu3U
XGPKPls3O18aNrGsW9cnhM9oPKvEz7+prJAJbC4WSS8LQaJ8Fz02zp8aFg4XdRep
SFL1VrRlE54QxwStlVUuMheKza5igs7QRGdtuFM42gVEzT2WfRdjlLEVHdJLsujy
KS/3c2pq7m72eogDt75gkYqj7fKPPqwoo8ZEppVwNrLXQoc1REqvzrkFhoLRdMSt
CgodsuD89tqbZ3rpJ0s6bkRxqCYhyjFvk1Vv+GIRN8yGNt9NTL831/bSvRc33tWm
c9ADJQCYXh7PEXddpdZiP00xb/d1Mhlxt1ST7l/u0mgRPEtJOh0DH65gnR7S7fDV
hGpXcYJzff/ptvR3nETgdRL2+UL4iXp5JxzHhgIjemkpCuzBP8Z3UL65+SwLIl6O
FQupgyjOLNiHgFqwykXECp6atYMLV68i+1DqO5dGmY8lC3hm5DpER6zWzc1K5G7T
3C65jF7RsVqvXdR+n7+YZf1QZNk7VnwiPjr2QCikRKgKpUCb0GjvplBwa7nzDE0c
eME5GI5sRZHf9QPMYONHoj5waM8TRwAE7U20Z0Eka0oSJ0vO9DMiiTxZjiLrgmaC
kU9+pHwBKungYvrHcC9AaLyGukmwonlvPVeBZy2ieu4YVaILi3drZpBOKGpNFE9G
wn2rLA4h3yRos6RyG/RZ
=dGHl
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
