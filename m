From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] OMAP2+: hwmod data: Fix wrong dma_system end address
Date: Wed, 20 Apr 2011 13:28:39 -0600
Message-ID: <20110420192837.16986.70873.stgit@twilight.localdomain>
References: <20110420192601.16986.56558.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110420192601.16986.56558.stgit@twilight.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Fillinger <m-fillinger@ti.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Benoit Cousson <b-cousson@ti.com>

OMAP2420, 2430 and 3xxx were using the OMAP4 end address
that unfortunately is not located at the same base address.
Moreover the OMAP4 size was set to 256 instead of 4096.

Change all .pa_end to set them to .pa_start + 0xfff

Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Reported-by: Michael Fillinger <m-fillinger@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 8eb3ce1..f50e56a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1782,7 +1782,7 @@ static struct omap_hwmod_irq_info omap2420_dma_system_irqs[] = {
 static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x48056000,
-		.pa_end		= 0x4a0560ff,
+		.pa_end		= 0x48056fff,
 		.flags		= ADDR_TYPE_RT
 	},
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index e6e3810..96753f7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1915,7 +1915,7 @@ static struct omap_hwmod_irq_info omap2430_dma_system_irqs[] = {
 static struct omap_hwmod_addr_space omap2430_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x48056000,
-		.pa_end		= 0x4a0560ff,
+		.pa_end		= 0x48056fff,
 		.flags		= ADDR_TYPE_RT
 	},
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b98e2df..9bee155 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2386,7 +2386,7 @@ static struct omap_hwmod_irq_info omap3xxx_dma_system_irqs[] = {
 static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x48056000,
-		.pa_end		= 0x4a0560ff,
+		.pa_end		= 0x48056fff,
 		.flags		= ADDR_TYPE_RT
 	},
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3e88dd3..abc548a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -885,7 +885,7 @@ static struct omap_hwmod_ocp_if *omap44xx_dma_system_masters[] = {
 static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x4a056000,
-		.pa_end		= 0x4a0560ff,
+		.pa_end		= 0x4a056fff,
 		.flags		= ADDR_TYPE_RT
 	},
 };
