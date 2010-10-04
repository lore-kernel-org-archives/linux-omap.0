From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH 4/5] arm/omap: remove duplicated include
Date: Mon, 4 Oct 2010 12:39:37 +0200
Message-ID: <20101004123937.4493b01b@absol.kitzblitz>
References: <20101004122436.7092868f@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101004122436.7092868f@absol.kitzblitz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/mach-omap2/board-cm-t35.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e10bc10..3308119 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -237,8 +237,6 @@ static inline void cm_t35_init_nand(void) {}
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 #include <linux/spi/ads7846.h>
 
-#include <plat/mcspi.h>
-
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,	/* 0: slave, 1: master */
-- 
1.7.2.2
