From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v3 4/4] arm/dts: Add tps65217 regulator DT data to
 am335x-bone.dts
Date: Fri, 24 Aug 2012 05:50:17 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA1F1D7@DBDE01.ent.ti.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-5-git-send-email-anilkumar@ti.com>
 <A823657F-0D26-429F-8E1C-DF1AE5AB78F4@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52059 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab2HXFus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 01:50:48 -0400
In-Reply-To: <A823657F-0D26-429F-8E1C-DF1AE5AB78F4@dominion.thruhere.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

Hi Koen,

On Thu, Aug 23, 2012 at 19:43:48, Koen Kooi wrote:
> 
> Op 21 aug. 2012, om 13:17 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:
> 
> > Add tps65217 regulator device tree data to AM335x-Bone by adding
> > regulator consumers with tightened constraints and regulator-name.
> > TPS65217 regulator handle can be obtained by using this regulator
> > name.
> > 
> > This patch also add I2C node with I2C frequency and tps65217 PMIC
> > I2C slave address.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> I tried this and the kernel immediately crashes on my beaglebone. Could you upload the complete git tree and .config you used to test this to somewhere public please?

Use this repo to test on beaglebone
https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-staging-pinctrl

This wiki talks about how to build and use?
https://github.com/hvaibhav/am335x-linux/wiki/How-To-Use-Upstream-Tree

Note: Enable tps65217 regulator in kernel config.

Regards
AnilKumar
