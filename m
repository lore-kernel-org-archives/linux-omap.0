From: Deepthy Ravi <deepthy.ravi@ti.com>
Subject: [PATCH 7/8] omap3evm: camera: Configure BT656 interface
Date: Thu, 8 Sep 2011 19:07:26 +0530
Message-ID: <1315489046-16332-1-git-send-email-deepthy.ravi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mchehab@infradead.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, g.liakhovetski@gmx.de, Vaibhav Hiremath <hvaibhav@ti.com>, Deepthy Ravi <deepthy.ravi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Hiremath <hvaibhav@ti.com>

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Deepthy Ravi <deepthy.ravi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm-camera.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm-camera.c b/arch/arm/mach-omap2/board-omap3evm-camera.c
index 718dd6d..e92fb13 100644
--- a/arch/arm/mach-omap2/board-omap3evm-camera.c
+++ b/arch/arm/mach-omap2/board-omap3evm-camera.c
@@ -141,9 +141,14 @@ static struct isp_v4l2_subdevs_group omap3evm_camera_subdevs[] = {
 		.interface      = ISP_INTERFACE_PARALLEL,
 		.bus            = {
 			.parallel       = {
-				.data_lane_shift        = 1,
-				.clk_pol                = 0,
-				.bridge                 = 0,
+				.width			= 8,
+				.data_lane_shift	= 1,
+				.clk_pol		= 0,
+				.hs_pol			= 0,
+				.vs_pol			= 1,
+				.fldmode		= 1,
+				.bridge			= 0,
+				.is_bt656		= 1,
 			},
 		}
 	},
-- 
1.7.0.4
