From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [Question] omap3 clock framework for clock set_rate
Date: Fri, 19 Jun 2009 09:38:31 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D542D43E@zmy16exm69.ds.mot.com>
References: <alpine.DEB.2.00.0906181816250.4087@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail55.messagelabs.com ([216.82.241.163]:57329 "EHLO
	mail55.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbZFSBjC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 21:39:02 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n5J1d4nY004554
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 18:39:04 -0700 (MST)
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n5J1d3EK010132
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 20:39:03 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n5J1d2mF010126
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 20:39:03 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.0906181816250.4087@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

=20

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]=20
> Sent: 2009=C4=EA6=D4=C219=C8=D5 8:18
> To: Wang Sawsd-A24013
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [Question] omap3 clock framework for clock set_rate
>=20
> Hello Chunqiu,
>=20
> On Fri, 19 Jun 2009, Wang Sawsd-A24013 wrote:
>=20
> > In linux-omap clock framework, most clocks have no
> > set_rate in their definition in clock34xx.h, but defined
> > DEFAULT_RATE in clksel_rate structures, this
> > Will only allow some pre-set rates for some clocks and
> > Can not get a more flexible rates if driver wants to
> > Change the clock rate usng clk_set_rate.
> >=20
> > What is the benefit of this implementation?
> >=20
> > We want to understand this before we made the change
> > In case we missed some imprtant background of
> > This implementation.
>=20
> Any driver that wishes to change its clock rate should add=20
> .set_rate and=20
> .round_rate function pointers to its corresponding clocks.  There's=20
> no good reason why those function pointers aren't there; they=20
> probably=20
> should have been added with the original clock tree.
>=20
> Hope this helps,

Thanks, this helps a lot. :-)
>=20
> - Paul
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
