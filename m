From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 10/24] ARM: davinci: Add dma_mask to eDMA devices
Date: Wed, 14 Oct 2015 14:42:52 +0300
Message-ID: <1444822986-20562-11-git-send-email-peter.ujfalusi@ti.com>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The upcoming change to merge the arch/arm/common/edma.c into
drivers/dma/edma.c will need this change when booting daVinci devices in
no DT mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 2 ++
 arch/arm/mach-davinci/dm355.c         | 1 +
 arch/arm/mach-davinci/dm644x.c        | 1 +
 arch/arm/mach-davinci/dm646x.c        | 1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 9f7d266faa0c..28c90bc372bd 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -216,6 +216,7 @@ static struct resource da850_edma1_resources[] = {
 static const struct platform_device_info da8xx_edma0_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= da8xx_edma0_resources,
 	.num_res	= ARRAY_SIZE(da8xx_edma0_resources),
 	.data		= &da8xx_edma0_pdata,
@@ -225,6 +226,7 @@ static const struct platform_device_info da8xx_edma0_device __initconst = {
 static const struct platform_device_info da850_edma1_device __initconst = {
 	.name		= "edma",
 	.id		= 1,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= da850_edma1_resources,
 	.num_res	= ARRAY_SIZE(da850_edma1_resources),
 	.data		= &da850_edma1_pdata,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5f10c6695e31..609950b8c191 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -616,6 +616,7 @@ static struct resource edma_resources[] = {
 static const struct platform_device_info dm355_edma_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= edma_resources,
 	.num_res	= ARRAY_SIZE(edma_resources),
 	.data		= &dm355_edma_pdata,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index aa3453b40d5f..d38f5049d56e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -545,6 +545,7 @@ static struct resource edma_resources[] = {
 static const struct platform_device_info dm644x_edma_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= edma_resources,
 	.num_res	= ARRAY_SIZE(edma_resources),
 	.data		= &dm644x_edma_pdata,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 79c1d8917dd3..70eb42725eec 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -592,6 +592,7 @@ static struct resource edma_resources[] = {
 static const struct platform_device_info dm646x_edma_device __initconst = {
 	.name		= "edma",
 	.id		= 0,
+	.dma_mask	= DMA_BIT_MASK(32),
 	.res		= edma_resources,
 	.num_res	= ARRAY_SIZE(edma_resources),
 	.data		= &dm646x_edma_pdata,
-- 
2.6.1
