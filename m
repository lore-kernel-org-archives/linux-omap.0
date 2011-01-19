From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv4 4/4] OMAP3: Devkit8000: Fix indentation of brace
Date: Wed, 19 Jan 2011 09:19:26 +0100
Message-ID: <1295425166-25540-5-git-send-email-weber@corscience.de>
References: <1295425166-25540-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295425166-25540-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>, charu@ti.com, sshtylyov@mvista.com
List-Id: linux-omap@vger.kernel.org

Fix indentation of a closing curly brace.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 4ddd81c..a344cd8 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -553,7 +553,7 @@ static void __init omap_dm9000_init(void)
 		printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
 			OMAP_DM9000_GPIO_IRQ);
 		return;
-		}
+	}
 
 	gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
 
-- 
1.7.4.rc2
