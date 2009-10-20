From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] omap: headers: Create headers necessary for
	compile under mach-omap1 and mach-omap2
Date: Tue, 20 Oct 2009 09:58:32 -0700
Message-ID: <20091020165831.GD12576@atomide.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com> <20091014214953.30227.83364.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61847 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZJTQ63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 12:58:29 -0400
Content-Disposition: inline
In-Reply-To: <20091014214953.30227.83364.stgit@kaulin.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Here's this one updated with the vmalloc.h split patch
inserted into the series earlier.

Regards,

Tony


>From 3eff851b9dc1e84aa0822772e0be9afb0c973585 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 19 Oct 2009 17:32:58 -0700
Subject: [PATCH] omap: headers: Create headers necessary for compile under mach-omap1 and mach-omap2

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
		if [ ! -f $file ]; then
			echo -ne "/*\n * $file\n */\n\n#include <plat/$header>\n" > $file
			git add $file
			if [ ! -f $plat_dir_new/$header ]; then
				git mv $mach_dir_old/$header $plat_dir_new/$header
			fi
		fi
	done
done

Signed-off-by: Tony Lindgren <tony@atomide.com>

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
