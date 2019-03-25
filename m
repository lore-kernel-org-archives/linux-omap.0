From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] ARM: OMAP2+: Define _HWMOD_STATE_DEFAULT and use it
Date: Mon, 25 Mar 2019 11:38:16 -0700
Message-ID: <20190325183819.15400-5-tony@atomide.com>
References: <20190325183819.15400-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325183819.15400-1-tony@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

For dynamically allocated struct hwmod entries probing with ti-sysc
interconnect target module driver, we need to specify the initial default
state the same way as we do for the platform data cases.

Let's prepare for that by adding _HWMOD_STATE_DEFAULT that we can then
use to set the initial default state without a need to add similar
CONFIG_PM handling in multiple places.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c         | 7 +------
 arch/arm/mach-omap2/omap_hwmod.h | 6 ++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -411,14 +411,9 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
 
 static void __init __maybe_unused omap_hwmod_init_postsetup(void)
 {
-	u8 postsetup_state;
+	u8 postsetup_state = _HWMOD_STATE_DEFAULT;
 
 	/* Set the default postsetup state for all hwmods */
-#ifdef CONFIG_PM
-	postsetup_state = _HWMOD_STATE_IDLE;
-#else
-	postsetup_state = _HWMOD_STATE_ENABLED;
-#endif
 	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
 }
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -493,6 +493,12 @@ struct omap_hwmod_omap4_prcm {
 #define _HWMOD_STATE_IDLE			5
 #define _HWMOD_STATE_DISABLED			6
 
+#ifdef CONFIG_PM
+#define _HWMOD_STATE_DEFAULT			_HWMOD_STATE_IDLE
+#else
+#define _HWMOD_STATE_DEFAULT			_HWMOD_STATE_ENABLED
+#endif
+
 /**
  * struct omap_hwmod_class - the type of an IP block
  * @name: name of the hwmod_class
-- 
2.21.0
