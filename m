From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 05/18] arm: common: edma: Save the number of event queues/TCs
Date: Thu, 13 Mar 2014 11:18:27 +0200
Message-ID: <1394702320-21743-6-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, joelf@ti.com, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, mporter@linaro.org, vinod.koul@intel.com, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

For later use save the number of queues available for the CC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 19520e2519d9..be267b2080be 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1770,6 +1770,9 @@ static int edma_probe(struct platform_device *pdev)
 			map_queue_tc(j, queue_tc_mapping[i][0],
 					queue_tc_mapping[i][1]);
 
+		/* Save the number of TCs */
+		edma_cc[j]->num_tc = i;
+
 		/* Event queue priority mapping */
 		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
 			assign_priority_to_queue(j,
-- 
1.9.0
