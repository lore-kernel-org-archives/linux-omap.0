From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] dma: cppi41: add missing directions bitfield
Date: Mon, 9 Mar 2015 10:50:20 -0500
Message-ID: <20150309155020.GD3739@saruman.tx.rr.com>
References: <1424904842-27902-1-git-send-email-balbi@ti.com>
 <20150304124323.GR2613@intel.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46087 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbbCIPu5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Mar 2015 11:50:57 -0400
Content-Disposition: inline
In-Reply-To: <20150304124323.GR2613@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Felipe Balbi <balbi@ti.com>, dmaengine@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>

--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2015 at 06:13:23PM +0530, Vinod Koul wrote:
> On Wed, Feb 25, 2015 at 04:54:02PM -0600, Felipe Balbi wrote:
> > Without those we will see a kernel WARN()
> > when loading musb on am335x devices.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/dma/cppi41.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> > index 512cb8e2805e..4e9cc8e8100c 100644
> > --- a/drivers/dma/cppi41.c
> > +++ b/drivers/dma/cppi41.c
> > @@ -926,6 +926,7 @@ static int cppi41_dma_probe(struct platform_device =
*pdev)
> >  	cdd->ddev.device_issue_pending =3D cppi41_dma_issue_pending;
> >  	cdd->ddev.device_prep_slave_sg =3D cppi41_dma_prep_slave_sg;
> >  	cdd->ddev.device_terminate_all =3D cppi41_stop_chan;
> > +	cdd->ddev.directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> >  	cdd->ddev.dev =3D dev;
> >  	INIT_LIST_HEAD(&cdd->ddev.channels);
> >  	cpp41_dma_info.dma_cap =3D cdd->ddev.cap_mask;
> Along with this please set src/dstn_addr_widths and residue_granularity
> please

will do.

--=20
balbi

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/cE8AAoJEIaOsuA1yqREu7AQAKFJvcqidaMGIf8JOa84X9Gv
GZbdSxpwV40hKV0W7VnwRveIh0HzOW2Y/QxLfGwCikEDTmuRaXlfzuu946yOd64L
myTokUfhcaD+KYk/r5Apyg492bISIIGAqVBQW0GyWfum/4IjiwM1KmNmmw31cJT5
KmodKRJT7G3NecTjkK7/Ii3vOrRp95YL0PfZxRMONIEccNn9GD0aiSMwL9x8WOTP
6Vfm/zJWjf1JNDLZeQWg53XLVC4nbF5llGavSsC2lSb18vyDyMMQMzIs3q5sfcdw
wwM5PQK8Jy//3H26opJEOqE31qZMp0AfBIV3UizhhZlQ0yo4ZgC/ANxnw6jtknu7
3bNyD0VJ0Ud/aAhWEPznvYh4m+UD/NQay98SaHLstXzw4GWBSIHlXRRPzAa35DTw
Sks+lJfJVBCoclL7TNcKcfFfmT073N/1a3ovN7iWf8kXLeVU3v7YCP6JrF0AyyD5
x5k7mequfPg3LsAuO8BSxH3DzWrEk5MryHWie2P+1qp80eOOkgdXK2+0kxw2xegn
IYLdQfieaQltDzxCV1U/XqBOPMFWFg/dsrZsemKPrW1I2/EGDE3XRE0rPEyeUVOg
BBvysKcn9Wm4IvlaHKSwpDWW2Ev6V9fejfG1OuAKmc2j33OQc499KCSkaBsxGt19
6PMOtb8Rj/mvE3gFh0U+
=dcgX
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
