From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 05/13] ARM/platform_data: edma: Remove queue_tc_mapping
 data from edma_soc_info
Date: Fri, 16 May 2014 15:17:12 +0300
Message-ID: <1400242640-9902-6-git-send-email-peter.ujfalusi@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: nsekhar@ti.com, joelf@ti.com, arnd@arndb.de
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

It is no longer in use by the driver or board files.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/edma.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 12f134b1493c..633e196ebdf2 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -175,7 +175,6 @@ struct edma_soc_info {
 	/* Resource reservation for other cores */
 	struct edma_rsv_info	*rsv;
 
-	s8	(*queue_tc_mapping)[2];
 	s8	(*queue_priority_mapping)[2];
 	const s16	(*xbar_chans)[2];
 };
-- 
1.9.3
