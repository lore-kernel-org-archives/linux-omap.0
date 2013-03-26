From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP baseline test results for v3.9-rc1
Date: Tue, 26 Mar 2013 18:44:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303261843500.23957@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EC281B4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39280 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab3CZSoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 14:44:37 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC281B4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, santosh.shilimkar@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, 14 Mar 2013, Hiremath, Vaibhav wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Tuesday, March 12, 2013 10:10 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Subject: OMAP baseline test results for v3.9-rc1
> > 
> > 
> > Here are some basic OMAP test results for Linux v3.9-rc1.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/
> > 
> > 
> > Test summary
> > ------------
> > 
> > Build:
> >     FAIL ( 4/16): am33xx_only, omap1_defconfig,
> This requires some cleanup in Makefile and Kconfig handling,
> 
> Either you disable SMP support for non-SMP devices like AM33xx 
> 
> OR
> 
> Fix the Makefile to resolve the build dependencies (may not be trivial)
> 
> OR
> 
> Make functions __weak so that build will go through.
> 
> 
> 
> I have created below patch, if it is ok with you then I can
> Submit patch for the same (build tested with am33xx_only and omap2plus_defconfig).

Santosh's suggestion seems the right way to go.  Care to implement a patch 
for #2 above?


- Paul
