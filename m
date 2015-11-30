From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/7] ARM: w90x900: make headers more local
Date: Tue,  1 Dec 2015 00:00:56 +0100
Message-ID: <1448924458-3279040-6-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some header files are never included outside of a mach-w90x900
directory and do not need to be made visible in include/mach,
so let's just move them all down one level.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-w90x900/cpu.c                           | 4 ++--
 arch/arm/mach-w90x900/{include/mach => }/regs-ebi.h   | 0
 arch/arm/mach-w90x900/{include/mach => }/regs-gcr.h   | 0
 arch/arm/mach-w90x900/{include/mach => }/regs-timer.h | 0
 arch/arm/mach-w90x900/{include/mach => }/regs-usb.h   | 0
 arch/arm/mach-w90x900/time.c                          | 2 +-
 6 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-ebi.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-gcr.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-timer.h (100%)
 rename arch/arm/mach-w90x900/{include/mach => }/regs-usb.h (100%)

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 213230ee57d1..ca763251ffe0 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -33,8 +33,8 @@
 #include <mach/hardware.h>
 #include <mach/regs-serial.h>
 #include <mach/regs-clock.h>
-#include <mach/regs-ebi.h>
-#include <mach/regs-timer.h>
+#include "regs-ebi.h"
+#include "regs-timer.h"
 
 #include "cpu.h"
 #include "clock.h"
diff --git a/arch/arm/mach-w90x900/include/mach/regs-ebi.h b/arch/arm/mach-w90x900/regs-ebi.h
similarity index 100%
rename from arch/arm/mach-w90x900/include/mach/regs-ebi.h
rename to arch/arm/mach-w90x900/regs-ebi.h
diff --git a/arch/arm/mach-w90x900/include/mach/regs-gcr.h b/arch/arm/mach-w90x900/regs-gcr.h
similarity index 100%
rename from arch/arm/mach-w90x900/include/mach/regs-gcr.h
rename to arch/arm/mach-w90x900/regs-gcr.h
diff --git a/arch/arm/mach-w90x900/include/mach/regs-timer.h b/arch/arm/mach-w90x900/regs-timer.h
similarity index 100%
rename from arch/arm/mach-w90x900/include/mach/regs-timer.h
rename to arch/arm/mach-w90x900/regs-timer.h
diff --git a/arch/arm/mach-w90x900/include/mach/regs-usb.h b/arch/arm/mach-w90x900/regs-usb.h
similarity index 100%
rename from arch/arm/mach-w90x900/include/mach/regs-usb.h
rename to arch/arm/mach-w90x900/regs-usb.h
diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
index cd1966ec9143..cda085245e34 100644
--- a/arch/arm/mach-w90x900/time.c
+++ b/arch/arm/mach-w90x900/time.c
@@ -31,7 +31,7 @@
 #include <asm/mach/time.h>
 
 #include <mach/map.h>
-#include <mach/regs-timer.h>
+#include "regs-timer.h"
 
 #include "nuc9xx.h"
 
-- 
2.1.0.rc2
