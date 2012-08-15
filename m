From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
Date: Wed, 15 Aug 2012 13:53:39 +0100
Message-ID: <20120815125338.GA13544@opensource.wolfsonmicro.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56827 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754150Ab2HOMxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Aug 2012 08:53:41 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Tue, Aug 14, 2012 at 02:25:18PM +0000, AnilKumar, Chimata wrote:

> AM335x EVM have one dedicated input supply which provide supplies to all
> the PMIC regulators. According to tps65910 "VDD1 regulator" input supply
> is from vcc1 so we have to create a dummy/parent/some node to handle this.
> Example below has the details.

Your device tree should accurately reflect the hardware.

> Similarly we have to add 7 more fixed regulators entries to provide input
> supply to different PMIC regulators.

If you have all these unrelated supplies in the system then your device
tree should accurately reflect that.  However this would be a very
unusual hardware design.  Usually there would be a very small set of
system supply rails, frequently only one.
