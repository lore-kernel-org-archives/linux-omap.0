From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/7] OMAP: 4430sdp: Correct fixed regulator
	device ID
Date: Tue,  7 Feb 2012 15:01:15 +0200
Message-ID: <1328619678-26080-5-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-arm-kernel@lists.infradead.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The board has two fixed voltage regulator. Correct the
device ID for the vbat, which used -1.
Create defines for the fixed regulator IDs so when adding new
regulators we know the next available ID to use for them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index f4ac553..d02172d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -62,6 +62,9 @@
 #define GPIO_WIFI_PMENA		54
 #define GPIO_WIFI_IRQ		53
 
+#define FIXED_REG_VBAT_ID	0
+#define FIXED_REG_VWLAN_ID	1
+
 static const int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(0, 1, KEY_R),
@@ -368,7 +371,7 @@ static struct fixed_voltage_config sdp4430_vbat_pdata = {
 
 static struct platform_device sdp4430_vbat = {
 	.name		= "reg-fixed-voltage",
-	.id		= -1,
+	.id		= FIXED_REG_VBAT_ID,
 	.dev = {
 		.platform_data = &sdp4430_vbat_pdata,
 	},
@@ -478,7 +481,7 @@ static struct fixed_voltage_config sdp4430_vwlan = {
 
 static struct platform_device omap_vwlan_device = {
 	.name		= "reg-fixed-voltage",
-	.id		= 1,
+	.id		= FIXED_REG_VWLAN_ID,
 	.dev = {
 		.platform_data = &sdp4430_vwlan,
 	},
-- 
1.7.8.4
