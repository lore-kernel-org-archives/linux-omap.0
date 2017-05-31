From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/11] ARM: OMAP2+: Remove unused legacy code for n8x0
Date: Wed, 31 May 2017 15:51:39 -0700
Message-ID: <20170531225139.30723-12-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -47,14 +47,12 @@ static u32 board_caps;
 
 static void board_check_revision(void)
 {
-	if (of_have_populated_dt()) {
-		if (of_machine_is_compatible("nokia,n800"))
-			board_caps = NOKIA_N800;
-		else if (of_machine_is_compatible("nokia,n810"))
-			board_caps = NOKIA_N810;
-		else if (of_machine_is_compatible("nokia,n810-wimax"))
-			board_caps = NOKIA_N810_WIMAX;
-	}
+	if (of_machine_is_compatible("nokia,n800"))
+		board_caps = NOKIA_N800;
+	else if (of_machine_is_compatible("nokia,n810"))
+		board_caps = NOKIA_N810;
+	else if (of_machine_is_compatible("nokia,n810-wimax"))
+		board_caps = NOKIA_N810_WIMAX;
 
 	if (!board_caps)
 		pr_err("Unknown board\n");
-- 
2.13.0
