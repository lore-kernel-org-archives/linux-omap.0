From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Query regarding clk framework - from .set_rate api
Date: Mon, 1 Apr 2013 11:06:59 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3E822@DBDE01.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
 <51596501.1020904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45986 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756891Ab3DALHL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 07:07:11 -0400
In-Reply-To: <51596501.1020904@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "mturquette@linaro.org" <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Nayak, Rajendra
> Sent: Monday, April 01, 2013 4:14 PM
> To: Hiremath, Vaibhav
> Cc: mturquette@linaro.org; Paul Walmsley; Tony Lindgren; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> khilman@deeprootsystems.com
> Subject: Re: Query regarding clk framework - from .set_rate api
>=20
> >
> > Where, the clk_set_rate() seems to be not working, and that's true
> > with the current implementation of OMAP/AM33xx clock tree,
> > as the CLK_SET_RATE_PARENT flag is not set to any of the clock node=
s.
> >
> > Please note that I am using DEFINE_STRUCT_CLK() macro for defining
> clocks
> > And which doesn't allow you to specify the flags.
>=20
> Use DEFINE_STRUCT_CLK_FLAGS() then. Its already used in AM33xx clock
> tree.

Its not there in my kernel baseline v3.8.5, that=92s why I missed it.
It got merged into v3.9-rc.

I am testing it now, and will update shortly.

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
