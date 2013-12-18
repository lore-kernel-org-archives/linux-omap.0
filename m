From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/7] usb: dwc3: pm_runtime implementation
Date: Wed, 18 Dec 2013 09:40:21 -0600
Message-ID: <20131218154021.GC1593@saruman.home>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <20131217233140.GA21267@psi-dev26.jf.intel.com>
 <20131217233554.GB21267@psi-dev26.jf.intel.com>
 <20131218153614.GB1593@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37782 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755155Ab3LRPlZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 10:41:25 -0500
Content-Disposition: inline
In-Reply-To: <20131218153614.GB1593@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: David Cohen <david.a.cohen@linux.intel.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 09:36:14AM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Tue, Dec 17, 2013 at 03:35:54PM -0800, David Cohen wrote:
> > On Tue, Dec 17, 2013 at 03:31:40PM -0800, David Cohen wrote:
> > > On Thu, Dec 12, 2013 at 03:38:38PM -0600, Felipe Balbi wrote:
> > > > hi all,
> > > >=20
> > > > these patches add pm_runtime support for all glue layers.
> > > >=20
> > > > I plan to add pm_runtime support for dwc3 after these
> > > > patches are merged upstream.
> > > >=20
> > > > Please test.
> > >=20
> > > At first time I failed to notice you were removing #ifdef's around pm
> > > callback functions. Instead of saying DWC3 will start to have warnings
> > > when CONFIG_PM is not selected, I'd say your patch set is now a
> > > dependence of my RFC :)
> >=20
> > I guess I said it in wrong order :P
> > Your patch set depends on my RFC.
>=20
> Or I just modify my patchset a little bit for now ;-)

nah, it looks horrible with all those ifdefs around. I'll delay my
patch series.

--=20
balbi

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSscHlAAoJEIaOsuA1yqREYqkQAJQ+hA19XxDmBOP9VagIcuVF
RA6X/UoKVHyx5M6g8I2w8sJt/ClZlWvEIpuglnjPWRPA0JqHi/Y7xtYwL0oF4fGk
q+W7dxwRMrq54Kb6l/BIpvKIYIpuGia4+yUoTYHOhdXPS80Yo/p4LFjvFgWzc5kZ
BfYnj7JiL1zqGYLk6RFU43bjc3jODYxoYNGNEo5olKtK/9KrDaxQqPw0CNc9P5qb
iQsALnDJIEB5RmcU3sA3JUIvSSZEB98UjVseQBi5ubvyGVGttWbrkjtFQiv5KnXz
ffI1ruyDxDB4a3IgJN1cDtnJUEOf2lIW7cA9G00GvB6pDyWDgvfe51xcsp6u/XvP
Vs1k29Eh5ttPVU1ruYybCOekCjbnmRCGhNTJ1F3XygbNsXoxbPxkBJMi1cIZmq+c
3nanL6MTiiULgNnYsq7xQRsT+9d3GdkIdM07TqJikEreSs7EaH0v5cZha0vQZ3hE
+wsxYaTCOEjD95ooKVAiQhmuDi0ExZudVoY9cjWAXo/78QGmuk7cPYqDEfiz5mZc
KeJix6qzt2pDtWCut/52zFbFwSzy+ABeVB3KI1t9YmUuw0zziWophsSPMa6sWQpC
Wd3yqTMpsjI4I3+fvUTUVXn4CPEBCx2vRRgqSbEtPeJSF/+aE2uTiC2oFTcdgUMs
ddCQTHpR6A7ekGyJ8olN
=Ba4m
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
