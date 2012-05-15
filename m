From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: gpmc: Modify interrupt handling
Date: Tue, 15 May 2012 15:06:43 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98C879@DBDE01.ent.ti.com>
References: <cover.1337090835.git.afzal@ti.com>
 <d193f1d968843c2580006bf3cde51f951de13892.1337090835.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50670 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933044Ab2EOPG4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 11:06:56 -0400
In-Reply-To: <d193f1d968843c2580006bf3cde51f951de13892.1337090835.git.afzal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Cc: "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>

Hi Tony,

On Tue, May 15, 2012 at 20:08:34, Mohammed, Afzal wrote:
> Modify interrupt handling such that interrupts can be handled by GPMC
> client drivers using standard interrupt APIs rather than requiring
> the drivers to have knowledge about GPMC interrupt handling. Currently
> only NAND related interrupts has been considered (which is the case
> even without this change) as the only user of GPMC interrupt is NAND.

:

> -	ret = request_irq(gpmc_irq, gpmc_handle_irq, IRQF_SHARED, "gpmc", NULL);

If this series could not be considered for 3.5, to prevent failure of
request_irq, either,

355f8ee  ARM: OMAP2+: GPMC: resolve type-conversion warning from sparse,

should be avoided, or diff [1] would be required, as shared irq needs dev-id.

Regards
Afzal

[1]
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 46b09da..9e1b726 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -768,7 +768,7 @@ static int __init gpmc_init(void)
                irq++;
        }

-       ret = request_irq(gpmc_irq, gpmc_handle_irq, IRQF_SHARED, "gpmc", NULL);
+       ret = request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
        if (ret)
                pr_err("gpmc: irq-%d could not claim: err %d\n",
                                                gpmc_irq, ret);

