From: Tim Nordell <tim.nordell@logicpd.com>
Subject: [PATCH] ARM: OMAP: Modified omap_mux_init_signal() to take in const char *
Date: Thu, 21 Oct 2010 13:50:41 -0500
Message-ID: <1287687041-22377-1-git-send-email-tim.nordell@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-145.static.twtelecom.net ([174.46.170.145]:54599
	"EHLO barracuda.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757100Ab0JUTHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Oct 2010 15:07:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tim Nordell <tim.nordell@logicpd.com>

If one does the following line twice with the old code:

omap_mux_init_signal("uart3_rts_sd.gpio_164", OMAP_PIN_INPUT);
omap_mux_init_signal("uart3_rts_sd.gpio_164", OMAP_PIN_INPUT);

the compiler optimizes the two const strings into one string
internally in the compiler.  The old code would modify the string
by inserting a NULL effectively making the second call become:

omap_mux_init_signal("uart3_rts_sd", OMAP_PIN_INPUT);

Since the code changes _all_ uart3_rts_sd signals over to this,
it'll cause unknown behavior, as well as making it more
difficult to track down the reason since the string
"uart3_rts_sd" by itself may not actually exist in your
normal mux initialization sequence.

Signed-off-by: Tim Nordell <tim.nordell@logicpd.com>
---
 arch/arm/mach-omap2/mux.c |   13 ++++++++-----
 arch/arm/mach-omap2/mux.h |    4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index ab403b2..b685540 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -127,19 +127,21 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	return 0;
 }
 
-int __init omap_mux_init_signal(char *muxname, int val)
+int __init omap_mux_init_signal(const char *muxname, int val)
 {
 	struct omap_mux_entry *e;
-	char *m0_name = NULL, *mode_name = NULL;
+	const char *m0_name = NULL, *mode_name = NULL;
 	int found = 0;
+	int m0_name_len;
 
 	mode_name = strchr(muxname, '.');
 	if (mode_name) {
-		*mode_name = '\0';
 		mode_name++;
 		m0_name = muxname;
+		m0_name_len = mode_name - muxname - 1;
 	} else {
 		mode_name = muxname;
+		m0_name_len = strlen(muxname);
 	}
 
 	list_for_each_entry(e, &muxmodes, node) {
@@ -147,7 +149,8 @@ int __init omap_mux_init_signal(char *muxname, int val)
 		char *m0_entry = m->muxnames[0];
 		int i;
 
-		if (m0_name && strcmp(m0_name, m0_entry))
+		if (m0_name && (strncmp(m0_name, m0_entry, m0_name_len)
+				|| strlen(m0_entry) != m0_name_len))
 			continue;
 
 		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
@@ -164,7 +167,7 @@ int __init omap_mux_init_signal(char *muxname, int val)
 				mux_mode = val | i;
 				printk(KERN_DEBUG "mux: Setting signal "
 					"%s.%s 0x%04x -> 0x%04x\n",
-					m0_entry, muxname, old_mode, mux_mode);
+					m0_entry, mode_cur, old_mode, mux_mode);
 				omap_mux_write(mux_mode, m->reg_offset);
 				found++;
 			}
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a8e040c..55e3a21 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -120,7 +120,7 @@ int omap_mux_init_gpio(int gpio, int val);
  * @muxname:		Mux name in mode0_name.signal_name format
  * @val:		Options for the mux register value
  */
-int omap_mux_init_signal(char *muxname, int val);
+int omap_mux_init_signal(const char *muxname, int val);
 
 #else
 
@@ -128,7 +128,7 @@ static inline int omap_mux_init_gpio(int gpio, int val)
 {
 	return 0;
 }
-static inline int omap_mux_init_signal(char *muxname, int val)
+static inline int omap_mux_init_signal(const char *muxname, int val)
 {
 	return 0;
 }
-- 
1.7.1

