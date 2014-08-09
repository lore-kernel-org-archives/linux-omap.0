From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Fri, 8 Aug 2014 21:49:52 -0500
Message-ID: <20140809024952.GA31064@saruman.home>
References: <20140730053940.GX29045@atomide.com>
 <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
 <20140731131107.GB29045@atomide.com>
 <alpine.DEB.2.02.1407311922350.1845@utopia.booyaka.com>
 <20140801071056.GD29045@atomide.com>
 <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
 <20140808021442.GA22811@saruman.home>
 <alpine.DEB.2.02.1408080610290.8332@utopia.booyaka.com>
 <20140808143411.GA2288@saruman.home>
 <alpine.DEB.2.02.1408082338380.30868@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41378 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbaHICvC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2014 22:51:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1408082338380.30868@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 08, 2014 at 11:39:08PM +0000, Paul Walmsley wrote:
> On Fri, 8 Aug 2014, Felipe Balbi wrote:
>=20
> > On Fri, Aug 08, 2014 at 06:11:54AM +0000, Paul Walmsley wrote:
> > > On Thu, 7 Aug 2014, Felipe Balbi wrote:
> > >=20
> > > > we have stable releases for that.
> > >=20
> > > Stable releases aren't a fix for process failures.
> >=20
> > of course not, but your claim that there's no way to fix v3.16 is
> > nonsense. And mistakes occur as well.
>=20
> There is no way to fix v3.16.=20

There is no way to fix *any* commit.

We can go back a few major releases and we will hit a point when ARM
multiplatform was enabled and the tree doesn't even build. There is no
way to fix that either, but I'm sure the patches fixing the build breaks
have been back ported to stable.

> The point of the -rc cycle is to stabilize the final, non-rc releases.

Well, stable release are *not* -rc releases and they exist in order to
fix bugs that were found after the final release has been tagged;
otherwise what would be the point of even having -stable ?

--=20
balbi

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT5YxQAAoJEIaOsuA1yqREvhMQAJ9p0rZf/5AiNokYxDJ5QEKt
R6buZT944iR2fMPrzLH49wtXZYiHWQq+yqe6ljfTzjYMn2PeOfVs11+lIymwxCN3
Ecv3pWbW4Gd6qjw/Uz1RtuwNmxDWaPy765PPdJsZEFCJHo6pfkonlObL8u0chYCO
K83sHnQXl5xUSUC52FOIhx4tTH1q0h8my9+infSgW4nZR9VW2EqUC0Wk+3t+XUQO
ZMU/oKWGHsOeh+vuFICVdUv7uU0d970odH0txrzRxcsXw/GMb72l9oWoSPFacnmx
Jibo+uVMezk6jYAPDpJFW6qx/gHGcMIwPdr0VH8cHea8aNLavmmmO++xrW9V3sUO
RCiBhGZiewDi5tXlh0MQEjCOpwRGvXTjg1eVohhy65z/z4CF0N0QOGRIRHo3caVV
zhXGLjV3to9ThiF+WCcsRXqkiTLeEjjaFSJG/pe3jNrACGgYeIneX0zMcTTk1ZDh
ZGb53XFfCsVEWRyv8y9rN8EnKTL1D0Dl5aFwoPWCCefFhFMxswUwrXgmhG7QAvil
fTCRt3MFCYPSJWZBJzFwH3MZ10aasEZVFAFfy9Z3x2KSe8eRmXeMBEXc/4bVvwZy
5XyMPFMMRQODO7PKTEr5lMNCwqDFGnoOUKvPSx0TrVWTE9YlXAePFpFDeu0AiJWW
Gqk6iWmJ0E8rS7QNQxo3
=/2pp
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
