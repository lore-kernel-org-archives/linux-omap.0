From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
Date: Thu, 16 Aug 2012 13:22:27 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
 <20120815165431.GF15365@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38587 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab2HPNWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Aug 2012 09:22:36 -0400
In-Reply-To: <20120815165431.GF15365@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Mark,

On Wed, Aug 15, 2012 at 22:24:32, Mark Brown wrote:
> On Wed, Aug 15, 2012 at 04:47:02PM +0000, AnilKumar, Chimata wrote:
> > On Wed, Aug 15, 2012 at 18:23:39, Mark Brown wrote:
> 
> > > If you have all these unrelated supplies in the system then your device
> > > tree should accurately reflect that.  However this would be a very
> 
> > In that case I have to add all these fixed regulators.
> 
> Why?  You then immediately go on to say...

Because all the nodes/regulators should be provided/registered otherwise
"regulator_dev_lookup" returns NULL if there are no regulator matches with
the supply_name.

I have gone through this thread
http://patchwork.ozlabs.org/patch/166682/

But problem here is single input supply battery/main is not sufficient.

pmic->desc[i].supply_name = info->vin_name;
with this assignment regulator core searches for exact supply name vcc1 or
vcc2 etc if there are no matches then it will not register any regulators. 

> 
> > > unusual hardware design.  Usually there would be a very small set of
> > > system supply rails, frequently only one.
> 
> > In case of AM335X-EVM one dedicated supply (5v) feeding to all the input
> > supplies (vcc1-7 and vccio) of the regulators.
> 
> ...that they all map onto the same physical supply?
> 

Yes single physical supply, if we want to add single fixed regulator node
to feed all the regulators then driver have to modify to support this.
Similar to revert of "regulator: tps65910: add support for input supply"
Patch.

Thanks
AnilKumar
