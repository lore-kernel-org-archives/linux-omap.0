From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 2/3] ARM: DRA7: RTC: Add lock and unlock functions
Date: Fri, 5 Feb 2016 11:12:31 +0530
Message-ID: <1454650952-20154-3-git-send-email-lokeshvutla@ti.com>
References: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hook omap_hwmod_rtc_unlock/lock functions into RTC hwmod,
so that SYSCONFIG register is updated properly

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 848356e..6625650 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1609,6 +1609,8 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
 static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
 	.name	= "rtcss",
 	.sysc	= &dra7xx_rtcss_sysc,
+	.unlock	= &omap_hwmod_rtc_unlock,
+	.lock	= &omap_hwmod_rtc_lock,
 };
 
 /* rtcss */
-- 
2.1.4
