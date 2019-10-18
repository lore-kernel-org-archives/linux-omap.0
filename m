From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ARM: OMAP2+: Make some functions static
Date: Fri, 18 Oct 2019 20:07:01 +0800
Message-ID: <20191018120701.29364-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, tony@atomide.com, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

Fix sparse warnings:

arch/arm/mach-omap2/pmic-cpcap.c:29:15: warning: symbol 'omap_cpcap_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/pmic-cpcap.c:43:15: warning: symbol 'omap_cpcap_uv_to_vsel' was not declared. Should it be static?
arch/arm/mach-omap2/pmic-cpcap.c:93:15: warning: symbol 'omap_max8952_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/pmic-cpcap.c:107:15: warning: symbol 'omap_max8952_uv_to_vsel' was not declared. Should it be static?
arch/arm/mach-omap2/pmic-cpcap.c:140:15: warning: symbol 'omap_fan535503_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/pmic-cpcap.c:155:15: warning: symbol 'omap_fan535508_vsel_to_uv' was not declared. Should it be static?
arch/arm/mach-omap2/pmic-cpcap.c:173:15: warning: symbol 'omap_fan535503_uv_to_vsel' was not declared. Should it be static?
arch/arm/mach-omap2/pmic-cpcap.c:192:15: warning: symbol 'omap_fan535508_uv_to_vsel' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/mach-omap2/pmic-cpcap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
index 2c2a178..3cdf40e 100644
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -26,7 +26,7 @@
  * Returns the microvolts DC that the CPCAP PMIC should generate when
  * programmed with @vsel.
  */
-unsigned long omap_cpcap_vsel_to_uv(unsigned char vsel)
+static unsigned long omap_cpcap_vsel_to_uv(unsigned char vsel)
 {
 	if (vsel > 0x44)
 		vsel = 0x44;
@@ -40,7 +40,7 @@ unsigned long omap_cpcap_vsel_to_uv(unsigned char vsel)
  * Returns the VSEL value necessary for the CPCAP PMIC to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
-unsigned char omap_cpcap_uv_to_vsel(unsigned long uv)
+static unsigned char omap_cpcap_uv_to_vsel(unsigned long uv)
 {
 	if (uv < 600000)
 		uv = 600000;
@@ -90,7 +90,7 @@ static struct omap_voltdm_pmic omap_cpcap_iva = {
  * Returns the microvolts DC that the MAX8952 Regulator should generate when
  * programmed with @vsel.
  */
-unsigned long omap_max8952_vsel_to_uv(unsigned char vsel)
+static unsigned long omap_max8952_vsel_to_uv(unsigned char vsel)
 {
 	if (vsel > 0x3F)
 		vsel = 0x3F;
@@ -104,7 +104,7 @@ unsigned long omap_max8952_vsel_to_uv(unsigned char vsel)
  * Returns the VSEL value necessary for the MAX8952 Regulator to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
-unsigned char omap_max8952_uv_to_vsel(unsigned long uv)
+static unsigned char omap_max8952_uv_to_vsel(unsigned long uv)
 {
 	if (uv < 770000)
 		uv = 770000;
@@ -137,7 +137,7 @@ static struct omap_voltdm_pmic omap443x_max8952_mpu = {
  * Returns the microvolts DC that the FAN535503 Regulator should generate when
  * programmed with @vsel.
  */
-unsigned long omap_fan535503_vsel_to_uv(unsigned char vsel)
+static unsigned long omap_fan535503_vsel_to_uv(unsigned char vsel)
 {
 	/* Extract bits[5:0] */
 	vsel &= 0x3F;
@@ -152,7 +152,7 @@ unsigned long omap_fan535503_vsel_to_uv(unsigned char vsel)
  * Returns the microvolts DC that the FAN535508 Regulator should generate when
  * programmed with @vsel.
  */
-unsigned long omap_fan535508_vsel_to_uv(unsigned char vsel)
+static unsigned long omap_fan535508_vsel_to_uv(unsigned char vsel)
 {
 	/* Extract bits[5:0] */
 	vsel &= 0x3F;
@@ -170,7 +170,7 @@ unsigned long omap_fan535508_vsel_to_uv(unsigned char vsel)
  * Returns the VSEL value necessary for the MAX8952 Regulator to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
-unsigned char omap_fan535503_uv_to_vsel(unsigned long uv)
+static unsigned char omap_fan535503_uv_to_vsel(unsigned long uv)
 {
 	unsigned char vsel;
 	if (uv < 750000)
@@ -189,7 +189,7 @@ unsigned char omap_fan535503_uv_to_vsel(unsigned long uv)
  * Returns the VSEL value necessary for the MAX8952 Regulator to
  * generate an output voltage equal to or greater than @uv microvolts DC.
  */
-unsigned char omap_fan535508_uv_to_vsel(unsigned long uv)
+static unsigned char omap_fan535508_uv_to_vsel(unsigned long uv)
 {
 	unsigned char vsel;
 	if (uv < 750000)
-- 
2.7.4
