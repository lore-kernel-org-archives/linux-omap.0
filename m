From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 2/2] ARM: OMAP3: cm-t35: add tvp5150 decoder support
Date: Wed, 13 Jun 2012 15:55:10 +0300
Message-ID: <1339592110-14312-3-git-send-email-lifshitz@compulab.co.il>
References: <1339592110-14312-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339592110-14312-1-git-send-email-lifshitz@compulab.co.il>
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
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Register the tvp5150 video decoder in ISP subsystem.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 05c66e8..97d7190 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -498,6 +498,9 @@ static struct i2c_board_info cm_t35_isp_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("mt9t001", 0x5d),
 	},
+	{
+		I2C_BOARD_INFO("tvp5150", 0x5c),
+	},
 };
 
 static struct isp_subdev_i2c_board_info cm_t35_isp_primary_subdevs[] = {
@@ -508,6 +511,14 @@ static struct isp_subdev_i2c_board_info cm_t35_isp_primary_subdevs[] = {
 	{ NULL, 0, },
 };
 
+static struct isp_subdev_i2c_board_info cm_t35_isp_secondary_subdevs[] = {
+	{
+		.board_info = &cm_t35_isp_i2c_boardinfo[1],
+		.i2c_adapter_id = 3,
+	},
+	{ NULL, 0, },
+};
+
 static struct isp_v4l2_subdevs_group cm_t35_isp_subdevs[] = {
 	{
 		.subdevs = cm_t35_isp_primary_subdevs,
@@ -518,6 +529,15 @@ static struct isp_v4l2_subdevs_group cm_t35_isp_subdevs[] = {
 			},
 		},
 	},
+	{
+		.subdevs = cm_t35_isp_secondary_subdevs,
+		.interface = ISP_INTERFACE_PARALLEL,
+		.bus = {
+			.parallel = {
+				.clk_pol = 0,
+			},
+		},
+	},
 	{ NULL, 0, },
 };
 
-- 
1.7.5.4
