From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: [PATCH] Keymap fix for f-sample and p2-sample.
Date: Mon, 27 Aug 2007 19:02:20 +0530
Message-ID: <46D2D264.3030508@celunite.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090207070909070300070801"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090207070909070300070801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
     The git tree is broken for p2-sample and f-sample , this patch 
fixes it.


Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>
---
  arch/arm/mach-omap1/board-fsample.c  |   14 ++++++--------
  arch/arm/mach-omap1/board-perseus2.c |   14 ++++++--------
  2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c
b/arch/arm/mach-omap1/board-fsample.c
index f65baa9..d5f6ea1 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -40,31 +40,29 @@ static int fsample_keymap[] = {
      KEY(0,1,KEY_RIGHT),
      KEY(0,2,KEY_LEFT),
      KEY(0,3,KEY_DOWN),
-    KEY(0,4,KEY_CENTER),
-    KEY(0,5,KEY_0_5),
-    KEY(1,0,KEY_SOFT2),
+    KEY(0,4,KEY_ENTER),
+    KEY(1,0,KEY_F10),
      KEY(1,1,KEY_SEND),
      KEY(1,2,KEY_END),
      KEY(1,3,KEY_VOLUMEDOWN),
      KEY(1,4,KEY_VOLUMEUP),
      KEY(1,5,KEY_RECORD),
-    KEY(2,0,KEY_SOFT1),
+    KEY(2,0,KEY_F9),
      KEY(2,1,KEY_3),
      KEY(2,2,KEY_6),
      KEY(2,3,KEY_9),
-    KEY(2,4,KEY_SHARP),
-    KEY(2,5,KEY_2_5),
+    KEY(2,4,KEY_KPDOT),
      KEY(3,0,KEY_BACK),
      KEY(3,1,KEY_2),
      KEY(3,2,KEY_5),
      KEY(3,3,KEY_8),
      KEY(3,4,KEY_0),
-    KEY(3,5,KEY_HEADSETHOOK),
+    KEY(3,5,KEY_KPSLASH),
      KEY(4,0,KEY_HOME),
      KEY(4,1,KEY_1),
      KEY(4,2,KEY_4),
      KEY(4,3,KEY_7),
-    KEY(4,4,KEY_STAR),
+    KEY(4,4,KEY_KPASTERISK),
      KEY(4,5,KEY_POWER),
      0
  };
diff --git a/arch/arm/mach-omap1/board-perseus2.c
b/arch/arm/mach-omap1/board-perseus2.c
index 2dec048..e9e352e 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -39,31 +39,29 @@ static int p2_keymap[] = {
      KEY(0,1,KEY_RIGHT),
      KEY(0,2,KEY_LEFT),
      KEY(0,3,KEY_DOWN),
-    KEY(0,4,KEY_CENTER),
-    KEY(0,5,KEY_0_5),
-    KEY(1,0,KEY_SOFT2),
+    KEY(0,4,KEY_ENTER),
+    KEY(1,0,KEY_F10),
      KEY(1,1,KEY_SEND),
      KEY(1,2,KEY_END),
      KEY(1,3,KEY_VOLUMEDOWN),
      KEY(1,4,KEY_VOLUMEUP),
      KEY(1,5,KEY_RECORD),
-    KEY(2,0,KEY_SOFT1),
+    KEY(2,0,KEY_F9),
      KEY(2,1,KEY_3),
      KEY(2,2,KEY_6),
      KEY(2,3,KEY_9),
-    KEY(2,4,KEY_SHARP),
-    KEY(2,5,KEY_2_5),
+    KEY(2,4,KEY_KPDOT),
      KEY(3,0,KEY_BACK),
      KEY(3,1,KEY_2),
      KEY(3,2,KEY_5),
      KEY(3,3,KEY_8),
      KEY(3,4,KEY_0),
-    KEY(3,5,KEY_HEADSETHOOK),
+    KEY(3,5,KEY_KPSLASH),
      KEY(4,0,KEY_HOME),
      KEY(4,1,KEY_1),
      KEY(4,2,KEY_4),
      KEY(4,3,KEY_7),
-    KEY(4,4,KEY_STAR),
+    KEY(4,4,KEY_KPASTERISK),
      KEY(4,5,KEY_POWER),
      0
  };
-- 
1.4.4.2



--------------090207070909070300070801
Content-Type: text/plain; name="0001-Keymap-fix-for-f-sample-and-p2-sample.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-Keymap-fix-for-f-sample-and-p2-sample.txt"

>From 6197fcf5401bb9bec192dce9eb31115d5ff0e53f Mon Sep 17 00:00:00 2001
From: Vivek Kutal <vivek.kutal@celunite.com>
Date: Fri, 24 Aug 2007 19:13:41 +0530
Subject: [PATCH] Keymap fix for f-sample and p2-sample.

Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>
---
 arch/arm/mach-omap1/board-fsample.c  |   14 ++++++--------
 arch/arm/mach-omap1/board-perseus2.c |   14 ++++++--------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index f65baa9..d5f6ea1 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -40,31 +40,29 @@ static int fsample_keymap[] = {
 	KEY(0,1,KEY_RIGHT),
 	KEY(0,2,KEY_LEFT),
 	KEY(0,3,KEY_DOWN),
-	KEY(0,4,KEY_CENTER),
-	KEY(0,5,KEY_0_5),
-	KEY(1,0,KEY_SOFT2),
+	KEY(0,4,KEY_ENTER),
+	KEY(1,0,KEY_F10),
 	KEY(1,1,KEY_SEND),
 	KEY(1,2,KEY_END),
 	KEY(1,3,KEY_VOLUMEDOWN),
 	KEY(1,4,KEY_VOLUMEUP),
 	KEY(1,5,KEY_RECORD),
-	KEY(2,0,KEY_SOFT1),
+	KEY(2,0,KEY_F9),
 	KEY(2,1,KEY_3),
 	KEY(2,2,KEY_6),
 	KEY(2,3,KEY_9),
-	KEY(2,4,KEY_SHARP),
-	KEY(2,5,KEY_2_5),
+	KEY(2,4,KEY_KPDOT),
 	KEY(3,0,KEY_BACK),
 	KEY(3,1,KEY_2),
 	KEY(3,2,KEY_5),
 	KEY(3,3,KEY_8),
 	KEY(3,4,KEY_0),
-	KEY(3,5,KEY_HEADSETHOOK),
+	KEY(3,5,KEY_KPSLASH),
 	KEY(4,0,KEY_HOME),
 	KEY(4,1,KEY_1),
 	KEY(4,2,KEY_4),
 	KEY(4,3,KEY_7),
-	KEY(4,4,KEY_STAR),
+	KEY(4,4,KEY_KPASTERISK),
 	KEY(4,5,KEY_POWER),
 	0
 };
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 2dec048..e9e352e 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -39,31 +39,29 @@ static int p2_keymap[] = {
 	KEY(0,1,KEY_RIGHT),
 	KEY(0,2,KEY_LEFT),
 	KEY(0,3,KEY_DOWN),
-	KEY(0,4,KEY_CENTER),
-	KEY(0,5,KEY_0_5),
-	KEY(1,0,KEY_SOFT2),
+	KEY(0,4,KEY_ENTER),
+	KEY(1,0,KEY_F10),
 	KEY(1,1,KEY_SEND),
 	KEY(1,2,KEY_END),
 	KEY(1,3,KEY_VOLUMEDOWN),
 	KEY(1,4,KEY_VOLUMEUP),
 	KEY(1,5,KEY_RECORD),
-	KEY(2,0,KEY_SOFT1),
+	KEY(2,0,KEY_F9),
 	KEY(2,1,KEY_3),
 	KEY(2,2,KEY_6),
 	KEY(2,3,KEY_9),
-	KEY(2,4,KEY_SHARP),
-	KEY(2,5,KEY_2_5),
+	KEY(2,4,KEY_KPDOT),
 	KEY(3,0,KEY_BACK),
 	KEY(3,1,KEY_2),
 	KEY(3,2,KEY_5),
 	KEY(3,3,KEY_8),
 	KEY(3,4,KEY_0),
-	KEY(3,5,KEY_HEADSETHOOK),
+	KEY(3,5,KEY_KPSLASH),
 	KEY(4,0,KEY_HOME),
 	KEY(4,1,KEY_1),
 	KEY(4,2,KEY_4),
 	KEY(4,3,KEY_7),
-	KEY(4,4,KEY_STAR),
+	KEY(4,4,KEY_KPASTERISK),
 	KEY(4,5,KEY_POWER),
 	0
 };
-- 
1.4.4.2




--------------090207070909070300070801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090207070909070300070801--
