From: "Andrzej Zaborowski" <balrog@zabor.org>
Subject: [PATCH] ARM: OMAP: Set keypad sense delays for the Palms.
Date: Sun, 26 Nov 2006 21:30:00 +0100
Message-ID: <11645730008-git-send-email-balrog@zabor.org>
Reply-To: balrogg@gmail.com
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Wait a fixed amount of time between writing to the columns
register and reading rows state to allow the keypad to respond
on Palm Tungsten E and Zire 71.  The value for Zire 71 keypad
was tested by Marek Vasut.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
---
 arch/arm/mach-omap1/board-palmte.c  |    1 +
 arch/arm/mach-omap1/board-palmz71.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 73e5f50..c23e8b6 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -70,6 +70,7 @@ static struct omap_kp_platform_data palm
 	.cols	= 8,
 	.keymap = palmte_keymap,
 	.rep	= 1,
+	.delay	= 12,
 };
 
 static struct resource palmte_kp_resources[] = {
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index ebcc6a7..b1ef1be 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -76,6 +76,7 @@ static struct omap_kp_platform_data palm
 	.cols	= 8,
 	.keymap	= palmz71_keymap,
 	.rep	= 1,
+	.delay	= 80,
 };
 
 static struct resource palmz71_kp_resources[] = {
-- 
1.4.3.2
