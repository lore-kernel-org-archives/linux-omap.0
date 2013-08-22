From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] ARM: OMAP2: use 'int' instead of 'unsigned' for variable
 'gpmc_irq_start'
Date: Thu, 22 Aug 2013 15:47:21 +0800
Message-ID: <5215C209.3080606@asianux.com>
References: <521479B4.8030604@asianux.com> <20130822071402.GQ7656@atomide.com>
 <5215C12D.5020807@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5215C12D.5020807@asianux.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

'gpmc_irq_start' is mostly used as 'int', and for a variable, do not
suggest to only use 'unsigned' as its type, so use 'int' instead of
'unsigned' for variable 'gpmc_irq_start'.

Also it will fix the related issue (dummy the real world failure):

  arch/arm/mach-omap2/gpmc.c:728:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/gpmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index f3fdd6a..9f4795a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -149,7 +149,7 @@ struct omap3_gpmc_regs {
 
 static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
 static struct irq_chip gpmc_irq_chip;
-static unsigned gpmc_irq_start;
+static int gpmc_irq_start;
 
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
-- 
1.7.7.6
