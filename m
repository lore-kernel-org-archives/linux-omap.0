From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 2/3] ARM: DRA7: RTC: Add lock and unlock functions
Date: Fri, 17 Jul 2015 17:20:32 +0530
Message-ID: <1437133833-32355-3-git-send-email-lokeshvutla@ti.com>
References: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: paul@pwsan.com, tony@atomide.com
Cc: t-kristo@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hook omap_hwmod_rtc_unlock/lock functions into RTC hwmod,
so that SYSCONFIG register is updated properly

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 2606c66..95d9bc5c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1572,6 +1572,8 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
 static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
 	.name	= "rtcss",
 	.sysc	= &dra7xx_rtcss_sysc,
+	.unlock	= &omap_hwmod_rtc_unlock,
+	.lock	= &omap_hwmod_rtc_lock,
 };
 
 /* rtcss */
-- 
2.1.4
