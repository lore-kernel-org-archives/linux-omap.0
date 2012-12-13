From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 23/23] mfd: omap-usb-host: Don't spam console on
 clk_set_parent failure
Date: Thu, 13 Dec 2012 12:46:35 +0200
Message-ID: <20121213104635.GF1916@arwen.pp.htv.fi>
References: <1354631514-24815-1-git-send-email-rogerq@ti.com>
 <1354631514-24815-8-git-send-email-rogerq@ti.com>
 <50BF4F30.4030903@mvista.com>
 <50BF569A.1080403@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50BF569A.1080403-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, bjorn-yOkvZcmFvRU@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2012 at 04:13:46PM +0200, Roger Quadros wrote:
> On 12/05/2012 03:42 PM, Sergei Shtylyov wrote:
> > Hello.
> >=20
> > On 04-12-2012 18:31, Roger Quadros wrote:
> >=20
> >> clk_set_parent is expected to fail on OMAP3 platforms. We don't
> >> consider that as fatal so don't spam console.
> >=20
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >> ---
> >>   drivers/mfd/omap-usb-host.c |   18 +++++++++---------
> >>   1 files changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> >> index 0bb54393..e5257dc 100644
> >> --- a/drivers/mfd/omap-usb-host.c
> >> +++ b/drivers/mfd/omap-usb-host.c
> >> @@ -657,32 +657,32 @@ static int __devinit usbhs_omap_probe(struct
> >> platform_device *pdev)
> >>       }
> >>
> >>       if (is_ehci_phy_mode(pdata->port_mode[0])) {
> >> -        /* for OMAP3 , the clk set paretn fails */
> >> +        /* for OMAP3, clk_set_parent fails */
> >>           ret =3D clk_set_parent(omap->utmi_clk[0],
> >>                       omap->xclk60mhsp1_ck);
> >>           if (ret !=3D 0)
> >> -            dev_err(dev, "xclk60mhsp1_ck set parent"
> >> -                "failed error:%d\n", ret);
> >> +            dev_dbg(dev, "xclk60mhsp1_ck set parent failed : %d\n",
> >> +                    ret);
> >>       } else if (is_ehci_tll_mode(pdata->port_mode[0])) {
> >>           ret =3D clk_set_parent(omap->utmi_clk[0],
> >>                       omap->init_60m_fclk);
> >>           if (ret !=3D 0)
> >> -            dev_err(dev, "init_60m_fclk set parent"
> >> -                "failed error:%d\n", ret);
> >> +            dev_dbg(dev, "P0 init_60m_fclk set parent failed: %d\n",
> >> +                    ret);
> >>       }
> >>
> >>       if (is_ehci_phy_mode(pdata->port_mode[1])) {
> >>           ret =3D clk_set_parent(omap->utmi_clk[1],
> >>                       omap->xclk60mhsp2_ck);
> >>           if (ret !=3D 0)
> >> -            dev_err(dev, "xclk60mhsp2_ck set parent"
> >> -                    "failed error:%d\n", ret);
> >> +            dev_dbg(dev, "xclk60mhsp2_ck set parent failed : %d\n",
> >> +                    ret);
> >>       } else if (is_ehci_tll_mode(pdata->port_mode[1])) {
> >>           ret =3D clk_set_parent(omap->utmi_clk[1],
> >>                           omap->init_60m_fclk);
> >>           if (ret !=3D 0)
> >> -            dev_err(dev, "init_60m_fclk set parent"
> >> -                "failed error:%d\n", ret);
> >> +            dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
> >> +                    ret);
> >=20
> >    Hm, you sometimes put a space before colon in the error message and
> > sometimes not. Inconsistent. :-)
> >=20
>=20
> That was because it fit in 80 characters without the space. I'm not sure
> what is more important, fitting in 80 or consistency in the print
> message. Maybe i should have removed the spaces everywhere so that it is
> consistent as well. :)

I'd say it's the consistency :-)

--=20
balbi

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQybILAAoJEIaOsuA1yqRE2GIP/2HroaOhkKAuazEBkX5dBFdj
It24MIAFe23+qlFrrT98b/uAvuBeBdgsfBSeE+V+shoookkeDU0F0MJHu4kDcUsz
XAyxbhrEElmCt8rCZGVkoN+yrzflhmQJJKRnIH+KoW+27aDVIvqDtZ5C9YcTcxYg
mnDcalwp/Jmhaz68XFvJPsdDLPE4cFr0cJ8kVt0NGrhReMWykMEjnaHmI9Qo3q7V
XtkBRobqeFtzxmBJze/yERcSCSgLqE49PhrWktemqOPLjC8nPrNymeOv+Uf/8TFT
3xZ+Aw1/l3o8EGCQtAjeL7MBsfj/sUVa+rwX5uIFg30zq7DzSXRjB+aTSlf0oOvC
PnE2Zv06dTgPVtfUQuJWrRTvjCM+RjEhF6bYNH4SnspibGiTLVvtHcwdnZvgvMUP
ySqfMyMMUtluCHImI5j8irnW/tEdIv2eT3gHvF84jIjpZuclfpt7CXpLbxuu/hVo
1BbR+H0iXSgRyHsfRflworzh8lTcmc0ybN2peuZGvRMU5ZMkqdnBD3SF24S9Y1Hc
GGwWJBF0rY33finqRrLj9rflXw9wTwuHYZkTum2Sdwi07aFzbwD2+wyLu9PHCFgc
+DAKoYTyaN4mFkptG05ot1Ghpxc45eSKpvWvTpSG63DkoJsmPkcLYqVfAePLB5oY
7bedbwU/ugQM3A6Q0qpc
=HaBa
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
