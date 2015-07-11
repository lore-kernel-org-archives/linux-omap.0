From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: sparse: add missing function declarations
Date: Sat, 11 Jul 2015 20:29:16 +0530
Message-ID: <3cb0fd46a493d80fad4d03316cdd6fb67a1938b7.1436622578.git.nsekhar@ti.com>
References: <cover.1436622578.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1436622578.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

omap3xxx_restart() and omap44xx_restart() are global
functions declared in common.h. Include this file
in omap3-restart.c and omap4-restart.c to prevent
sparse warnings of type:

arch/arm/mach-omap2/omap4-restart.c:22:6: warning: symbol 'omap44xx_restart' was not declared. Should it be static?

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/omap3-restart.c | 1 +
 arch/arm/mach-omap2/omap4-restart.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap3-restart.c b/arch/arm/mach-omap2/omap3-restart.c
index 103a49f68bcb..4bdd22edb96b 100644
--- a/arch/arm/mach-omap2/omap3-restart.c
+++ b/arch/arm/mach-omap2/omap3-restart.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/reboot.h>
 
+#include "common.h"
 #include "control.h"
 #include "prm.h"
 
diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
index a99e7f7fb5be..e17136a50e27 100644
--- a/arch/arm/mach-omap2/omap4-restart.c
+++ b/arch/arm/mach-omap2/omap4-restart.c
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/reboot.h>
+#include "common.h"
 #include "prm.h"
 
 /**
-- 
2.4.4.408.g16da57c
