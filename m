From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
Date: Wed, 15 Aug 2012 17:54:32 +0100
Message-ID: <20120815165431.GF15365@opensource.wolfsonmicro.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60059 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781Ab2HOQye (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 12:54:34 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Wed, Aug 15, 2012 at 04:47:02PM +0000, AnilKumar, Chimata wrote:
> On Wed, Aug 15, 2012 at 18:23:39, Mark Brown wrote:

> > If you have all these unrelated supplies in the system then your device
> > tree should accurately reflect that.  However this would be a very

> In that case I have to add all these fixed regulators.

Why?  You then immediately go on to say...

> > unusual hardware design.  Usually there would be a very small set of
> > system supply rails, frequently only one.

> In case of AM335X-EVM one dedicated supply (5v) feeding to all the input
> supplies (vcc1-7 and vccio) of the regulators.

...that they all map onto the same physical supply?
