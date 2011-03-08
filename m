From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 01/18] I2C: OMAP2+: Set hwmod flags to only allow 16-bit
	accesses to i2c
Date: Tue, 08 Mar 2011 11:07:27 +0000
Message-ID: <20110308110727.23531.15577.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Andy Green <andy.green@linaro.org>, Ben Dooks <ben-linux@fluff.org>, patches@linaro.org
List-Id: linux-omap@vger.kernel.org

Peter Maydell noticed when running under QEMU he was getting
errors reporting 32-bit access to I2C peripheral unit registers
that are documented to be 8 or 16-bit only[1][2]

The I2C driver is blameless as it wraps its accesses in a
function using __raw_writew and __raw_readw, it turned out it
is the hwmod stuff.

However the hwmod code already has a flag to force a
perhipheral unit to only be accessed using 16-bit operations.

This patch applies the 16-bit only flag to the 2430,
OMAP3xxx and OMAP44xx hwmod structs.  2420 was already
correctly marked up as 16-bit.

The 2430 change will need testing by TI as arranged
in the comments to the previous patch version.

When the 16-bit flag is or-ed with other flags, it is placed
first as requested in comments.

[1] OMAP4430 Technical reference manual section 23.1.6.2
[2] OMAP3530 Techincal reference manual section 18.6

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4aa74d7..e5c0ced 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1545,6 +1545,7 @@ static struct omap_hwmod_ocp_if *omap2430_i2c1_slaves[] = {
 
 static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.name		= "i2c1",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
 	.sdma_reqs	= i2c1_sdma_reqs,
@@ -1591,6 +1592,7 @@ static struct omap_hwmod_ocp_if *omap2430_i2c2_slaves[] = {
 
 static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.name		= "i2c2",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
 	.sdma_reqs	= i2c2_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e2792cf..63527b6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1892,6 +1892,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
 	.sdma_reqs	= i2c1_sdma_reqs,
@@ -1934,6 +1935,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
 	.sdma_reqs	= i2c2_sdma_reqs,
@@ -1976,6 +1978,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
 	.sdma_reqs	= i2c3_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7dbcdf7..2c86f0c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2126,7 +2126,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
@@ -2179,7 +2179,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
 static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
@@ -2232,7 +2232,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
 static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
@@ -2285,7 +2285,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
 static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
