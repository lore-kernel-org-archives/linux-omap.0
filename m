From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Query regarding clk framework - from .set_rate api
Date: Mon, 1 Apr 2013 11:20:04 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3E84A@DBDE01.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
 <51596501.1020904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60349 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756693Ab3DALUM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 07:20:12 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "mturquette@linaro.org" <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, April 01, 2013 4:37 PM
> To: Nayak, Rajendra
> Cc: mturquette@linaro.org; Paul Walmsley; Tony Lindgren; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> khilman@deeprootsystems.com
> Subject: RE: Query regarding clk framework - from .set_rate api
>=20
> > -----Original Message-----
> > From: Nayak, Rajendra
> > Sent: Monday, April 01, 2013 4:14 PM
> > To: Hiremath, Vaibhav
> > Cc: mturquette@linaro.org; Paul Walmsley; Tony Lindgren; linux-
> > omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > khilman@deeprootsystems.com
> > Subject: Re: Query regarding clk framework - from .set_rate api
> >
> > >
> > > Where, the clk_set_rate() seems to be not working, and that's tru=
e
> > > with the current implementation of OMAP/AM33xx clock tree,
> > > as the CLK_SET_RATE_PARENT flag is not set to any of the clock
> nodes.
> > >
> > > Please note that I am using DEFINE_STRUCT_CLK() macro for definin=
g
> > clocks
> > > And which doesn't allow you to specify the flags.
> >
> > Use DEFINE_STRUCT_CLK_FLAGS() then. Its already used in AM33xx cloc=
k
> > tree.
>=20
> Its not there in my kernel baseline v3.8.5, that=92s why I missed it.
> It got merged into v3.9-rc.
>=20
> I am testing it now, and will update shortly.
>=20

And it works fine...

Sorry for the noise, I should have checked mainline status
before drafting this email.

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
