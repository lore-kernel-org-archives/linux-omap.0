From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Thu, 7 Aug 2014 21:14:42 -0500
Message-ID: <20140808021442.GA22811@saruman.home>
References: <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com>
 <20140729145312.GT29045@atomide.com>
 <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com>
 <20140730053940.GX29045@atomide.com>
 <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
 <20140731131107.GB29045@atomide.com>
 <alpine.DEB.2.02.1407311922350.1845@utopia.booyaka.com>
 <20140801071056.GD29045@atomide.com>
 <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47723 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705AbaHHCPq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Aug 2014 22:15:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 07, 2014 at 10:21:23PM +0000, Paul Walmsley wrote:
> On Fri, 1 Aug 2014, Tony Lindgren wrote:
>=20
> > * Paul Walmsley <paul@pwsan.com> [140731 12:29]:
> > > On Thu, 31 Jul 2014, Tony Lindgren wrote:
> > >=20
> > > > * Paul Walmsley <paul@pwsan.com> [140730 00:55]:
> > > > > On Tue, 29 Jul 2014, Tony Lindgren wrote:
> > > > >=20
> > > > > > The following patch should fix the tests above for 3530es3beagl=
e.
> > > > > > Care to test and ack as I don't have one?
> > > > >=20
> > > > > 3530es3beagle retention dynamic idle tests hang on next-20140729.=
  (Maybe=20
> > > > > other boards fail too - haven't tested any others). =20
> > > >=20
> > > > I just checked that today's linux next works for off-idle and
> > > > wake-up events for at least 37xx evm.
> > >=20
> > > I ran the full set of tests across all boards.  The only board that p=
assed=20
> > > the dynamic idle testing on next-20140729 was the 3730beaglexm.
> > >=20
> > > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/READM=
E.txt
> > >=20
> > > 37xxevm hangs on the first suspend entry:
> > >=20
> > > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/pm/37=
xxevm/37xxevm_log.txt
> > >=20
> > > If I find some extra time, I'll set up a bisection run.
> >=20
> > OK that sounds like some driver suspend regression that needs
> > to be tracked down. I'm seeing it on my 37xx evm also with
> > linux next too.
>=20
> It's commit a71e3c37960ce5f9c6a519bc1215e3ba9fa83e75:
>=20
> Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date:   Wed Jul 23 16:47:31 2014 -0300
>=20
>     net: phy: Set the driver when registering an MDIO bus device
>    =20
>     mdiobus_register() registers a device which is already bound to a dri=
ver.
>     Hence, the driver pointer should be set properly in order to track do=
wn
>     the driver associated to the MDIO bus.
>    =20
>     This will be used to allow ethernet driver to pin down a MDIO bus dri=
ver,
>     preventing it from being unloaded while the PHY device is running.
>    =20
>     Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>     Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
>=20
> What's bad is that this went in late during v3.16-rc fixes.  So now v3.16=
=20
> itself is broken, and there's no way to fix it.

we have stable releases for that.

--=20
balbi

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT5DKSAAoJEIaOsuA1yqREuVsP+wboSeb2DX2dw5PZj98vNU8g
qoz1w4zVQ8y/a2VFlQmx++Gcmo4V0tFto9qFEwJWo96zgJLCb2Y9dMBBlmo/jk/N
tWjUZ0upa0GL60FII6iBU+deuflLggxbBwhfGuHUtLX0nTpbXXA/Wxz1kbK+BcsF
N/YXr+nPudREiS/3nDLZNECDn6oa2CwQ91jqKfsKxFu1MbQdppVPqLTuRN0qGm47
q4581pcT3mp0KynAcKkKqJgxlwXn81WQxy9rC5L7LGoBCXORNV6a0IY3Nwt7Sayx
FOex148E8hyqvVLUyYWfxuAMxQZmb72dA/P8YAv42XVTCT+fRcJ93hq9p0SX93k+
kvOqELhNRKD/SJe9YehWDDlYfmeb/ojLY5fc74JOYQ4XDQSVAuOxzn1eJiJfTsjf
7nnKl6hn5PVk1JBVjCYIWr91lz5mXo7SSgWD+EZ3E1v0BiyYDk87vZFAIejw0dJL
B9p+lbk3QFhQVjjj3AC+g+pAaaUBMDJVVG+jt7FLy4S2oL0B64K9Sq1FdRhFdOaE
jo93W4U/ltmDs0eVFFhKglPOkOcYDzFnFZ0Vps7rAvI5RkqRs7jwtB5PPA9Br2+0
ubC9wbgL9RKxG+aATOAKiOSVUGtHeZ/5Ib0BsdDKTzGdKslK1V5ddp2Vd+1FgzoP
QBpxm8LrbKpDDJeEbXJO
=eO6I
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
