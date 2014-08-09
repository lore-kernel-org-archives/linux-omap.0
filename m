From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Sat, 9 Aug 2014 09:41:24 -0300
Message-ID: <20140809124124.GA1201@arch.cereza>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:43238 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750900AbaHIMm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Aug 2014 08:42:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1408072210300.5770@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org, Felipe Balbi <balbi@ti.com>

On 07 Aug 10:21 PM, Paul Walmsley wrote:
> On Fri, 1 Aug 2014, Tony Lindgren wrote:
>=20
> > * Paul Walmsley <paul@pwsan.com> [140731 12:29]:
> > > On Thu, 31 Jul 2014, Tony Lindgren wrote:
> > >=20
> > > > * Paul Walmsley <paul@pwsan.com> [140730 00:55]:
> > > > > On Tue, 29 Jul 2014, Tony Lindgren wrote:
> > > > >=20
> > > > > > The following patch should fix the tests above for 3530es3b=
eagle.
> > > > > > Care to test and ack as I don't have one?
> > > > >=20
> > > > > 3530es3beagle retention dynamic idle tests hang on next-20140=
729.  (Maybe=20
> > > > > other boards fail too - haven't tested any others). =20
> > > >=20
> > > > I just checked that today's linux next works for off-idle and
> > > > wake-up events for at least 37xx evm.
> > >=20
> > > I ran the full set of tests across all boards.  The only board th=
at passed=20
> > > the dynamic idle testing on next-20140729 was the 3730beaglexm.
> > >=20
> > > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/R=
EADME.txt
> > >=20
> > > 37xxevm hangs on the first suspend entry:
> > >=20
> > > http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/p=
m/37xxevm/37xxevm_log.txt
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
>     mdiobus_register() registers a device which is already bound to a=
 driver.
>     Hence, the driver pointer should be set properly in order to trac=
k down
>     the driver associated to the MDIO bus.
>    =20
>     This will be used to allow ethernet driver to pin down a MDIO bus=
 driver,
>     preventing it from being unloaded while the PHY device is running=
=2E
>    =20
>     Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>     Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>     Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.co=
m>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
>=20
> What's bad is that this went in late during v3.16-rc fixes.  So now v=
3.16=20
> itself is broken, and there's no way to fix it.
>=20
> As far as I can tell, this patch doesn't fix a regression.  So no way=
 it=20
> should have gone in during late -rc kernels.
>=20

Indeed, the commit shouldn't have landed as a v3.16-rc fix. FWIW, it wa=
s
originally intended for v3.17, but I wasn't clear enough about this whe=
n it
was submitted.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
