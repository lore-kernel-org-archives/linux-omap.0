From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 16/35] arm: omap: irq: add specific compatibles for omap3 and am33xx devices
Date: Mon, 28 Jul 2014 16:16:04 -0500
Message-ID: <1406582183-696-17-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406582183-696-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

with this, we can use a compatible flag to figure
out how many irq lines are wired up, no need for
our TI-specific ti,intc-size binding.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 465d725..97845df 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -320,7 +320,9 @@ static int __init intc_of_init(struct device_node *node,
 	return 0;
 }
 
-IRQCHIP_DECLARE(omap_intc, "ti,omap2-intc", intc_of_init);
+IRQCHIP_DECLARE(omap2_intc, "ti,omap2-intc", intc_of_init);
+IRQCHIP_DECLARE(omap3_intc, "ti,omap3-intc", intc_of_init);
+IRQCHIP_DECLARE(am33xx_intc, "ti,am33xx-intc", intc_of_init);
 
 asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
 {
-- 
2.0.1.563.g66f467c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
