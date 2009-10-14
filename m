From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] omap: headers: Create headers necessary for compile under
	mach-omap1 and mach-omap2
Date: Wed, 14 Oct 2009 14:49:53 -0700
Message-ID: <20091014214953.30227.83364.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014213748.30227.71513.stgit@kaulin.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Create the headers needed for compiling under
mach-omap1/include/mach and mach-omap2/include/mach.

This was done with the following script:

#!/bin/bash
mach_files="clkdev.h gpio.h hardware.h io.h irqs.h memory.h \
smp.h system.h timex.h uncompress.h vmalloc.h"
omaps="mach-omap1 mach-omap2"

mach_dir_old="arch/arm/plat-omap/include/mach"
plat_dir_new="arch/arm/plat-omap/include/plat"

mkdir -p $plat_dir_new
git add $plat_dir_new

for dir in $omaps; do
	mach_dir_new="arch/arm/$dir/include/mach"
	for header in $mach_files; do
		file="$mach_dir_new/$header"
		echo -ne "/*\n * $file\n */\n\n#include <plat/$header>\n" > $file
		git add $file
		git mv $mach_dir_old/$header $plat_dir_new/$header
	done
done

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

 arch/arm/mach-omap1/include/mach/clkdev.h     |    5 
 arch/arm/mach-omap1/include/mach/gpio.h       |    5 
 arch/arm/mach-omap1/include/mach/hardware.h   |    5 
 arch/arm/mach-omap1/include/mach/io.h         |    5 
 arch/arm/mach-omap1/include/mach/irqs.h       |    5 
 arch/arm/mach-omap1/include/mach/memory.h     |    5 
 arch/arm/mach-omap1/include/mach/smp.h        |    5 
 arch/arm/mach-omap1/include/mach/system.h     |    5 
 arch/arm/mach-omap1/include/mach/timex.h      |    5 
 arch/arm/mach-omap1/include/mach/uncompress.h |    5 
 arch/arm/mach-omap1/include/mach/vmalloc.h    |    5 
 arch/arm/mach-omap2/include/mach/clkdev.h     |    5 
 arch/arm/mach-omap2/include/mach/gpio.h       |    5 
 arch/arm/mach-omap2/include/mach/hardware.h   |    5 
 arch/arm/mach-omap2/include/mach/io.h         |    5 
 arch/arm/mach-omap2/include/mach/irqs.h       |    5 
 arch/arm/mach-omap2/include/mach/memory.h     |    5 
 arch/arm/mach-omap2/include/mach/smp.h        |    5 
 arch/arm/mach-omap2/include/mach/system.h     |    5 
 arch/arm/mach-omap2/include/mach/timex.h      |    5 
 arch/arm/mach-omap2/include/mach/uncompress.h |    5 
 arch/arm/mach-omap2/include/mach/vmalloc.h    |    5 
 arch/arm/plat-omap/include/mach/clkdev.h      |   13 -
 arch/arm/plat-omap/include/mach/gpio.h        |  128 ------
 arch/arm/plat-omap/include/mach/hardware.h    |  290 -------------
 arch/arm/plat-omap/include/mach/io.h          |  241 -----------
 arch/arm/plat-omap/include/mach/irqs.h        |  568 -------------------------
 arch/arm/plat-omap/include/mach/memory.h      |   96 ----
 arch/arm/plat-omap/include/mach/smp.h         |   51 --
 arch/arm/plat-omap/include/mach/system.h      |   51 --
 arch/arm/plat-omap/include/mach/timex.h       |   41 --
 arch/arm/plat-omap/include/mach/uncompress.h  |   83 ----
 arch/arm/plat-omap/include/mach/vmalloc.h     |   21 -
 arch/arm/plat-omap/include/plat/clkdev.h      |   13 +
 arch/arm/plat-omap/include/plat/gpio.h        |  128 ++++++
 arch/arm/plat-omap/include/plat/hardware.h    |  290 +++++++++++++
 arch/arm/plat-omap/include/plat/io.h          |  241 +++++++++++
 arch/arm/plat-omap/include/plat/irqs.h        |  568 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/memory.h      |   96 ++++
 arch/arm/plat-omap/include/plat/smp.h         |   51 ++
 arch/arm/plat-omap/include/plat/system.h      |   51 ++
 arch/arm/plat-omap/include/plat/timex.h       |   41 ++
 arch/arm/plat-omap/include/plat/uncompress.h  |   83 ++++
 arch/arm/plat-omap/include/plat/vmalloc.h     |   21 +
 44 files changed, 1693 insertions(+), 1583 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-omap1/include/mach/gpio.h
 create mode 100644 arch/arm/mach-omap1/include/mach/hardware.h
 create mode 100644 arch/arm/mach-omap1/include/mach/io.h
 create mode 100644 arch/arm/mach-omap1/include/mach/irqs.h
 create mode 100644 arch/arm/mach-omap1/include/mach/memory.h
 create mode 100644 arch/arm/mach-omap1/include/mach/smp.h
 create mode 100644 arch/arm/mach-omap1/include/mach/system.h
 create mode 100644 arch/arm/mach-omap1/include/mach/timex.h
 create mode 100644 arch/arm/mach-omap1/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-omap1/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-omap2/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-omap2/include/mach/gpio.h
 create mode 100644 arch/arm/mach-omap2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-omap2/include/mach/io.h
 create mode 100644 arch/arm/mach-omap2/include/mach/irqs.h
 create mode 100644 arch/arm/mach-omap2/include/mach/memory.h
 create mode 100644 arch/arm/mach-omap2/include/mach/smp.h
 create mode 100644 arch/arm/mach-omap2/include/mach/system.h
 create mode 100644 arch/arm/mach-omap2/include/mach/timex.h
 create mode 100644 arch/arm/mach-omap2/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-omap2/include/mach/vmalloc.h
 delete mode 100644 arch/arm/plat-omap/include/mach/clkdev.h
 delete mode 100644 arch/arm/plat-omap/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-omap/include/mach/hardware.h
 delete mode 100644 arch/arm/plat-omap/include/mach/io.h
 delete mode 100644 arch/arm/plat-omap/include/mach/irqs.h
 delete mode 100644 arch/arm/plat-omap/include/mach/memory.h
 delete mode 100644 arch/arm/plat-omap/include/mach/smp.h
 delete mode 100644 arch/arm/plat-omap/include/mach/system.h
 delete mode 100644 arch/arm/plat-omap/include/mach/timex.h
 delete mode 100644 arch/arm/plat-omap/include/mach/uncompress.h
 delete mode 100644 arch/arm/plat-omap/include/mach/vmalloc.h
 create mode 100644 arch/arm/plat-omap/include/plat/clkdev.h
 create mode 100644 arch/arm/plat-omap/include/plat/gpio.h
 create mode 100644 arch/arm/plat-omap/include/plat/hardware.h
 create mode 100644 arch/arm/plat-omap/include/plat/io.h
 create mode 100644 arch/arm/plat-omap/include/plat/irqs.h
 create mode 100644 arch/arm/plat-omap/include/plat/memory.h
 create mode 100644 arch/arm/plat-omap/include/plat/smp.h
 create mode 100644 arch/arm/plat-omap/include/plat/system.h
 create mode 100644 arch/arm/plat-omap/include/plat/timex.h
 create mode 100644 arch/arm/plat-omap/include/plat/uncompress.h
 create mode 100644 arch/arm/plat-omap/include/plat/vmalloc.h

diff --git a/arch/arm/mach-omap1/include/mach/clkdev.h b/arch/arm/mach-omap1/include/mach/clkdev.h
new file mode 100644
index 0000000..ea8640e
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/clkdev.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/clkdev.h
+ */
+
+#include <plat/clkdev.h>
diff --git a/arch/arm/mach-omap1/include/mach/gpio.h b/arch/arm/mach-omap1/include/mach/gpio.h
new file mode 100644
index 0000000..e737706
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/gpio.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/gpio.h
+ */
+
+#include <plat/gpio.h>
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
new file mode 100644
index 0000000..a3f6287
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/hardware.h
+ */
+
+#include <plat/hardware.h>
diff --git a/arch/arm/mach-omap1/include/mach/io.h b/arch/arm/mach-omap1/include/mach/io.h
new file mode 100644
index 0000000..57bdf74
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/io.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/io.h
+ */
+
+#include <plat/io.h>
diff --git a/arch/arm/mach-omap1/include/mach/irqs.h b/arch/arm/mach-omap1/include/mach/irqs.h
new file mode 100644
index 0000000..9292fdc
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/irqs.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/irqs.h
+ */
+
+#include <plat/irqs.h>
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
new file mode 100644
index 0000000..e9b600c
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/memory.h
+ */
+
+#include <plat/memory.h>
diff --git a/arch/arm/mach-omap1/include/mach/smp.h b/arch/arm/mach-omap1/include/mach/smp.h
new file mode 100644
index 0000000..80a371c
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/smp.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/smp.h
+ */
+
+#include <plat/smp.h>
diff --git a/arch/arm/mach-omap1/include/mach/system.h b/arch/arm/mach-omap1/include/mach/system.h
new file mode 100644
index 0000000..a6c1b3a
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/system.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/system.h
+ */
+
+#include <plat/system.h>
diff --git a/arch/arm/mach-omap1/include/mach/timex.h b/arch/arm/mach-omap1/include/mach/timex.h
new file mode 100644
index 0000000..4793790
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/timex.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/timex.h
+ */
+
+#include <plat/timex.h>
diff --git a/arch/arm/mach-omap1/include/mach/uncompress.h b/arch/arm/mach-omap1/include/mach/uncompress.h
new file mode 100644
index 0000000..0ff22dc
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/uncompress.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/uncompress.h
+ */
+
+#include <plat/uncompress.h>
diff --git a/arch/arm/mach-omap1/include/mach/vmalloc.h b/arch/arm/mach-omap1/include/mach/vmalloc.h
new file mode 100644
index 0000000..085a18a
--- /dev/null
+++ b/arch/arm/mach-omap1/include/mach/vmalloc.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap1/include/mach/vmalloc.h
+ */
+
+#include <plat/vmalloc.h>
diff --git a/arch/arm/mach-omap2/include/mach/clkdev.h b/arch/arm/mach-omap2/include/mach/clkdev.h
new file mode 100644
index 0000000..53b0274
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/clkdev.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/clkdev.h
+ */
+
+#include <plat/clkdev.h>
diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
new file mode 100644
index 0000000..be4d290
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/gpio.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/gpio.h
+ */
+
+#include <plat/gpio.h>
diff --git a/arch/arm/mach-omap2/include/mach/hardware.h b/arch/arm/mach-omap2/include/mach/hardware.h
new file mode 100644
index 0000000..78edf9d
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/hardware.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/hardware.h
+ */
+
+#include <plat/hardware.h>
diff --git a/arch/arm/mach-omap2/include/mach/io.h b/arch/arm/mach-omap2/include/mach/io.h
new file mode 100644
index 0000000..fd78f31
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/io.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/io.h
+ */
+
+#include <plat/io.h>
diff --git a/arch/arm/mach-omap2/include/mach/irqs.h b/arch/arm/mach-omap2/include/mach/irqs.h
new file mode 100644
index 0000000..44dab77
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/irqs.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/irqs.h
+ */
+
+#include <plat/irqs.h>
diff --git a/arch/arm/mach-omap2/include/mach/memory.h b/arch/arm/mach-omap2/include/mach/memory.h
new file mode 100644
index 0000000..ca6d32a
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/memory.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/memory.h
+ */
+
+#include <plat/memory.h>
diff --git a/arch/arm/mach-omap2/include/mach/smp.h b/arch/arm/mach-omap2/include/mach/smp.h
new file mode 100644
index 0000000..323675f
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/smp.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/smp.h
+ */
+
+#include <plat/smp.h>
diff --git a/arch/arm/mach-omap2/include/mach/system.h b/arch/arm/mach-omap2/include/mach/system.h
new file mode 100644
index 0000000..d488721
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/system.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/system.h
+ */
+
+#include <plat/system.h>
diff --git a/arch/arm/mach-omap2/include/mach/timex.h b/arch/arm/mach-omap2/include/mach/timex.h
new file mode 100644
index 0000000..de9f8fc
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/timex.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/timex.h
+ */
+
+#include <plat/timex.h>
diff --git a/arch/arm/mach-omap2/include/mach/uncompress.h b/arch/arm/mach-omap2/include/mach/uncompress.h
new file mode 100644
index 0000000..78e0557
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/uncompress.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/uncompress.h
+ */
+
+#include <plat/uncompress.h>
diff --git a/arch/arm/mach-omap2/include/mach/vmalloc.h b/arch/arm/mach-omap2/include/mach/vmalloc.h
new file mode 100644
index 0000000..1423223
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/vmalloc.h
@@ -0,0 +1,5 @@
+/*
+ * arch/arm/mach-omap2/include/mach/vmalloc.h
+ */
+
+#include <plat/vmalloc.h>
diff --git a/arch/arm/plat-omap/include/mach/clkdev.h b/arch/arm/plat-omap/include/plat/clkdev.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/clkdev.h
rename to arch/arm/plat-omap/include/plat/clkdev.h
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/gpio.h
rename to arch/arm/plat-omap/include/plat/gpio.h
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/hardware.h
rename to arch/arm/plat-omap/include/plat/hardware.h
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/plat/io.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/io.h
rename to arch/arm/plat-omap/include/plat/io.h
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/irqs.h
rename to arch/arm/plat-omap/include/plat/irqs.h
diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat-omap/include/plat/memory.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/memory.h
rename to arch/arm/plat-omap/include/plat/memory.h
diff --git a/arch/arm/plat-omap/include/mach/smp.h b/arch/arm/plat-omap/include/plat/smp.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/smp.h
rename to arch/arm/plat-omap/include/plat/smp.h
diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/plat/system.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/system.h
rename to arch/arm/plat-omap/include/plat/system.h
diff --git a/arch/arm/plat-omap/include/mach/timex.h b/arch/arm/plat-omap/include/plat/timex.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/timex.h
rename to arch/arm/plat-omap/include/plat/timex.h
diff --git a/arch/arm/plat-omap/include/mach/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/uncompress.h
rename to arch/arm/plat-omap/include/plat/uncompress.h
diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/plat-omap/include/plat/vmalloc.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/vmalloc.h
rename to arch/arm/plat-omap/include/plat/vmalloc.h
