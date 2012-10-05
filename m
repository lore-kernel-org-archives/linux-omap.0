From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 01/15] ARM: OMAP2+: gpmc: annotate exit sections properly
Date: Fri, 5 Oct 2012 21:23:20 +0530
Message-ID: <a517afd9ed3be069b475caae791156b9c4663849.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab2JEPxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 11:53:31 -0400
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

compiler complained,
`gpmc_remove' referenced in section `.data' of arch/arm/mach-omap2/built-in.o: defined in discarded section `.exit.text' of arch/arm/mach-omap2/built-in.o

Annotate gpmc_remove function and dependents with __devexit.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2cbdcb9..163458d 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -886,7 +886,7 @@ static int gpmc_setup_irq(void)
 	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
 }
 
-static __exit int gpmc_free_irq(void)
+static __devexit int gpmc_free_irq(void)
 {
 	int i;
 
@@ -992,7 +992,7 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static __exit int gpmc_remove(struct platform_device *pdev)
+static __devexit int gpmc_remove(struct platform_device *pdev)
 {
 	gpmc_free_irq();
 	gpmc_mem_exit();
-- 
1.7.12

