From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP4+: Fix bad fallthrough for cpuidle
Date: Wed, 26 Oct 2016 08:17:01 -0700
Message-ID: <20161026151703.24730-4-tony@atomide.com>
References: <20161026151703.24730-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161026151703.24730-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Dave Gerlach <d-gerlach@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Pau Pajuel <ppajuel@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We don't want to fall through to a bunch of errors for retention
if PM_OMAP4_CPU_OSWR_DISABLE is not configured for a SoC.

Fixes: 6099dd37c669 ("ARM: OMAP5 / DRA7: Enable CPU RET on suspend")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -244,10 +244,9 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		save_state = 1;
 		break;
 	case PWRDM_POWER_RET:
-		if (IS_PM44XX_ERRATUM(PM_OMAP4_CPU_OSWR_DISABLE)) {
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_CPU_OSWR_DISABLE))
 			save_state = 0;
-			break;
-		}
+		break;
 	default:
 		/*
 		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
-- 
2.9.3
