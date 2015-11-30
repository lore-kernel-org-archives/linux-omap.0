From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/7] ARM: ks8695: make headers more local
Date: Tue,  1 Dec 2015 00:00:53 +0100
Message-ID: <1448924458-3279040-3-git-send-email-arnd@arndb.de>
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

Some header files are never included outside of a mach-ks8695
directory and do not need to be made visible in include/mach,
so let's just move them all down one level.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/board-acs5k.c                  | 2 +-
 arch/arm/mach-ks8695/board-dsm320.c                 | 2 +-
 arch/arm/mach-ks8695/board-micrel.c                 | 2 +-
 arch/arm/mach-ks8695/board-og.c                     | 2 +-
 arch/arm/mach-ks8695/board-sg.c                     | 2 +-
 arch/arm/mach-ks8695/cpu.c                          | 2 +-
 arch/arm/mach-ks8695/devices.c                      | 6 +++---
 arch/arm/mach-ks8695/{include/mach => }/devices.h   | 0
 arch/arm/mach-ks8695/pci.c                          | 4 ++--
 arch/arm/mach-ks8695/{include/mach => }/regs-hpna.h | 0
 arch/arm/mach-ks8695/{include/mach => }/regs-lan.h  | 0
 arch/arm/mach-ks8695/{include/mach => }/regs-mem.h  | 0
 arch/arm/mach-ks8695/{include/mach => }/regs-pci.h  | 0
 arch/arm/mach-ks8695/{include/mach => }/regs-sys.h  | 0
 arch/arm/mach-ks8695/{include/mach => }/regs-wan.h  | 0
 15 files changed, 11 insertions(+), 11 deletions(-)
 rename arch/arm/mach-ks8695/{include/mach => }/devices.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-hpna.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-lan.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-mem.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-pci.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-sys.h (100%)
 rename arch/arm/mach-ks8695/{include/mach => }/regs-wan.h (100%)

diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index 9f9c0441a917..e4d709c8ed32 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -33,7 +33,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/devices.h>
+#include "devices.h"
 #include <mach/gpio-ks8695.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-ks8695/board-dsm320.c b/arch/arm/mach-ks8695/board-dsm320.c
index d37c218c3584..13537e9c5485 100644
--- a/arch/arm/mach-ks8695/board-dsm320.c
+++ b/arch/arm/mach-ks8695/board-dsm320.c
@@ -28,7 +28,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/devices.h>
+#include "devices.h"
 #include <mach/gpio-ks8695.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-ks8695/board-micrel.c b/arch/arm/mach-ks8695/board-micrel.c
index 3acbdfd31391..69cfb9935fc1 100644
--- a/arch/arm/mach-ks8695/board-micrel.c
+++ b/arch/arm/mach-ks8695/board-micrel.c
@@ -19,7 +19,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/gpio-ks8695.h>
-#include <mach/devices.h>
+#include "devices.h"
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
index f2658168eeff..1f4f2f4f25bb 100644
--- a/arch/arm/mach-ks8695/board-og.c
+++ b/arch/arm/mach-ks8695/board-og.c
@@ -18,7 +18,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/devices.h>
+#include "devices.h"
 #include <mach/regs-gpio.h>
 #include <mach/gpio-ks8695.h>
 #include "generic.h"
diff --git a/arch/arm/mach-ks8695/board-sg.c b/arch/arm/mach-ks8695/board-sg.c
index fdf2352d2cf8..46e455c3821b 100644
--- a/arch/arm/mach-ks8695/board-sg.c
+++ b/arch/arm/mach-ks8695/board-sg.c
@@ -16,7 +16,7 @@
 #include <linux/mtd/partitions.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/devices.h>
+#include "devices.h"
 #include "generic.h"
 
 /*
diff --git a/arch/arm/mach-ks8695/cpu.c b/arch/arm/mach-ks8695/cpu.c
index ddb24222918e..474a050da85b 100644
--- a/arch/arm/mach-ks8695/cpu.c
+++ b/arch/arm/mach-ks8695/cpu.c
@@ -30,7 +30,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/regs-sys.h>
+#include "regs-sys.h"
 #include <mach/regs-misc.h>
 
 
diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
index 47399bc3c024..61cf20beb45f 100644
--- a/arch/arm/mach-ks8695/devices.c
+++ b/arch/arm/mach-ks8695/devices.c
@@ -24,9 +24,9 @@
 #include <linux/platform_device.h>
 
 #include <mach/irqs.h>
-#include <mach/regs-wan.h>
-#include <mach/regs-lan.h>
-#include <mach/regs-hpna.h>
+#include "regs-wan.h"
+#include "regs-lan.h"
+#include "regs-hpna.h"
 #include <mach/regs-switch.h>
 #include <mach/regs-misc.h>
 
diff --git a/arch/arm/mach-ks8695/include/mach/devices.h b/arch/arm/mach-ks8695/devices.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/devices.h
rename to arch/arm/mach-ks8695/devices.h
diff --git a/arch/arm/mach-ks8695/pci.c b/arch/arm/mach-ks8695/pci.c
index c1bc4c3716ed..577a35f75c8a 100644
--- a/arch/arm/mach-ks8695/pci.c
+++ b/arch/arm/mach-ks8695/pci.c
@@ -33,8 +33,8 @@
 #include <asm/mach/pci.h>
 #include <mach/hardware.h>
 
-#include <mach/devices.h>
-#include <mach/regs-pci.h>
+#include "devices.h"
+#include "regs-pci.h"
 
 
 static int pci_dbg;
diff --git a/arch/arm/mach-ks8695/include/mach/regs-hpna.h b/arch/arm/mach-ks8695/regs-hpna.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/regs-hpna.h
rename to arch/arm/mach-ks8695/regs-hpna.h
diff --git a/arch/arm/mach-ks8695/include/mach/regs-lan.h b/arch/arm/mach-ks8695/regs-lan.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/regs-lan.h
rename to arch/arm/mach-ks8695/regs-lan.h
diff --git a/arch/arm/mach-ks8695/include/mach/regs-mem.h b/arch/arm/mach-ks8695/regs-mem.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/regs-mem.h
rename to arch/arm/mach-ks8695/regs-mem.h
diff --git a/arch/arm/mach-ks8695/include/mach/regs-pci.h b/arch/arm/mach-ks8695/regs-pci.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/regs-pci.h
rename to arch/arm/mach-ks8695/regs-pci.h
diff --git a/arch/arm/mach-ks8695/include/mach/regs-sys.h b/arch/arm/mach-ks8695/regs-sys.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/regs-sys.h
rename to arch/arm/mach-ks8695/regs-sys.h
diff --git a/arch/arm/mach-ks8695/include/mach/regs-wan.h b/arch/arm/mach-ks8695/regs-wan.h
similarity index 100%
rename from arch/arm/mach-ks8695/include/mach/regs-wan.h
rename to arch/arm/mach-ks8695/regs-wan.h
-- 
2.1.0.rc2
