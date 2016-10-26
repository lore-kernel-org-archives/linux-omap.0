From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] ARM: OMAP5: Fix build for PM code
Date: Wed, 26 Oct 2016 08:16:59 -0700
Message-ID: <20161026151703.24730-2-tony@atomide.com>
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

It's CONFIG_SOC_OMAP5, not CONFIG_ARCH_OMAP5. Looks like make randconfig
builds have not hit this one yet.

Fixes: b3bf289c1c45 ("ARM: OMAP2+: Fix build with CONFIG_SMP and CONFIG_PM
is not set")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -80,7 +80,7 @@ endif
 # Power Management
 omap-4-5-pm-common			= omap-mpuss-lowpower.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
-obj-$(CONFIG_ARCH_OMAP5)		+= $(omap-4-5-pm-common)
+obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
 obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
 
 ifeq ($(CONFIG_PM),y)
-- 
2.9.3
