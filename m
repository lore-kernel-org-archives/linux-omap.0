From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
Date: Wed, 15 Aug 2012 16:47:02 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868Ab2HOQrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 12:47:11 -0400
In-Reply-To: <20120815125338.GA13544@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi Mark,

On Wed, Aug 15, 2012 at 18:23:39, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 02:25:18PM +0000, AnilKumar, Chimata wrote:
> 
> > AM335x EVM have one dedicated input supply which provide supplies to all
> > the PMIC regulators. According to tps65910 "VDD1 regulator" input supply
> > is from vcc1 so we have to create a dummy/parent/some node to handle this.
> > Example below has the details.
> 
> Your device tree should accurately reflect the hardware.
> 
> > Similarly we have to add 7 more fixed regulators entries to provide input
> > supply to different PMIC regulators.
> 
> If you have all these unrelated supplies in the system then your device
> tree should accurately reflect that.  However this would be a very

In that case I have to add all these fixed regulators.

> unusual hardware design.  Usually there would be a very small set of
> system supply rails, frequently only one.

In case of AM335X-EVM one dedicated supply (5v) feeding to all the input
supplies (vcc1-7 and vccio) of the regulators.

tps65910 PMIC have vcc1-7 and vccio input supplies which are feeding to
all the regulators. (like one - one and one - many).

Tps65910 regulator drivers registration fails if we not providing the
correct input supply with supply name. One option I can see is that
fixed voltage regulators. If we do this then total 21 (8 input supply
fixed regulators and others are out regulators) are present in the system.

If this is the correct approach then I will submit next version of patch.

Thanks
AnilKumar


