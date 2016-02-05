From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] ARM: drop unused Makefile.boot of Multiplatform SoCs
Date: Sat,  6 Feb 2016 02:36:48 +0900
Message-ID: <1454693808-13081-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <vireshk@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, spear-devel@list.st.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, Santosh Shilimkar <ssantosh@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Barry Song <baohua@kernel.org>, Eric Miao <eric.y.miao@gmail.com>, linux-ker
List-Id: linux-omap@vger.kernel.org

The variable "MACHINE" is empty if CONFIG_ARCH_MULTIPLATFORM=y,
so these Makefile.boot files are never included.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-cns3xxx/Makefile.boot    | 3 ---
 arch/arm/mach-exynos/Makefile.boot     | 2 --
 arch/arm/mach-integrator/Makefile.boot | 4 ----
 arch/arm/mach-keystone/Makefile.boot   | 1 -
 arch/arm/mach-mmp/Makefile.boot        | 1 -
 arch/arm/mach-mv78xx0/Makefile.boot    | 3 ---
 arch/arm/mach-nspire/Makefile.boot     | 0
 arch/arm/mach-omap2/Makefile.boot      | 3 ---
 arch/arm/mach-orion5x/Makefile.boot    | 3 ---
 arch/arm/mach-prima2/Makefile.boot     | 3 ---
 arch/arm/mach-realview/Makefile.boot   | 9 ---------
 arch/arm/mach-s3c64xx/Makefile.boot    | 2 --
 arch/arm/mach-spear/Makefile.boot      | 3 ---
 arch/arm/mach-u300/Makefile.boot       | 4 ----
 arch/arm/mach-ux500/Makefile.boot      | 3 ---
 arch/arm/mach-zynq/Makefile.boot       | 3 ---
 16 files changed, 47 deletions(-)
 delete mode 100644 arch/arm/mach-cns3xxx/Makefile.boot
 delete mode 100644 arch/arm/mach-exynos/Makefile.boot
 delete mode 100644 arch/arm/mach-integrator/Makefile.boot
 delete mode 100644 arch/arm/mach-keystone/Makefile.boot
 delete mode 100644 arch/arm/mach-mmp/Makefile.boot
 delete mode 100644 arch/arm/mach-mv78xx0/Makefile.boot
 delete mode 100644 arch/arm/mach-nspire/Makefile.boot
 delete mode 100644 arch/arm/mach-omap2/Makefile.boot
 delete mode 100644 arch/arm/mach-orion5x/Makefile.boot
 delete mode 100644 arch/arm/mach-prima2/Makefile.boot
 delete mode 100644 arch/arm/mach-realview/Makefile.boot
 delete mode 100644 arch/arm/mach-s3c64xx/Makefile.boot
 delete mode 100644 arch/arm/mach-spear/Makefile.boot
 delete mode 100644 arch/arm/mach-u300/Makefile.boot
 delete mode 100644 arch/arm/mach-ux500/Makefile.boot
 delete mode 100644 arch/arm/mach-zynq/Makefile.boot

diff --git a/arch/arm/mach-cns3xxx/Makefile.boot b/arch/arm/mach-cns3xxx/Makefile.boot
deleted file mode 100644
index d079de0..0000000
--- a/arch/arm/mach-cns3xxx/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00C00000
diff --git a/arch/arm/mach-exynos/Makefile.boot b/arch/arm/mach-exynos/Makefile.boot
deleted file mode 100644
index b9862e2..0000000
--- a/arch/arm/mach-exynos/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	+= 0x40008000
-params_phys-y	:= 0x40000100
diff --git a/arch/arm/mach-integrator/Makefile.boot b/arch/arm/mach-integrator/Makefile.boot
deleted file mode 100644
index ff0a4b5..0000000
--- a/arch/arm/mach-integrator/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-
diff --git a/arch/arm/mach-keystone/Makefile.boot b/arch/arm/mach-keystone/Makefile.boot
deleted file mode 100644
index f3835c4..0000000
--- a/arch/arm/mach-keystone/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y	:= 0x80008000
diff --git a/arch/arm/mach-mmp/Makefile.boot b/arch/arm/mach-mmp/Makefile.boot
deleted file mode 100644
index 5edf03e..0000000
--- a/arch/arm/mach-mmp/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-   zreladdr-y	+= 0x00008000
diff --git a/arch/arm/mach-mv78xx0/Makefile.boot b/arch/arm/mach-mv78xx0/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-mv78xx0/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-nspire/Makefile.boot b/arch/arm/mach-nspire/Makefile.boot
deleted file mode 100644
index e69de29..0000000
diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
deleted file mode 100644
index b03e562..0000000
--- a/arch/arm/mach-omap2/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-  zreladdr-y		+= 0x80008000
-params_phys-y		:= 0x80000100
-initrd_phys-y		:= 0x80800000
diff --git a/arch/arm/mach-orion5x/Makefile.boot b/arch/arm/mach-orion5x/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-orion5x/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-prima2/Makefile.boot
deleted file mode 100644
index c77a488..0000000
--- a/arch/arm/mach-prima2/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-zreladdr-y		+= 0x00008000
-params_phys-y		:= 0x00000100
-initrd_phys-y		:= 0x00800000
diff --git a/arch/arm/mach-realview/Makefile.boot b/arch/arm/mach-realview/Makefile.boot
deleted file mode 100644
index d2c3d78..0000000
--- a/arch/arm/mach-realview/Makefile.boot
+++ /dev/null
@@ -1,9 +0,0 @@
-ifeq ($(CONFIG_REALVIEW_HIGH_PHYS_OFFSET),y)
-   zreladdr-y	+= 0x70008000
-params_phys-y	:= 0x70000100
-initrd_phys-y	:= 0x70800000
-else
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-endif
diff --git a/arch/arm/mach-s3c64xx/Makefile.boot b/arch/arm/mach-s3c64xx/Makefile.boot
deleted file mode 100644
index c642333..0000000
--- a/arch/arm/mach-s3c64xx/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	+= 0x50008000
-params_phys-y	:= 0x50000100
diff --git a/arch/arm/mach-spear/Makefile.boot b/arch/arm/mach-spear/Makefile.boot
deleted file mode 100644
index 4674a4c..0000000
--- a/arch/arm/mach-spear/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-u300/Makefile.boot b/arch/arm/mach-u300/Makefile.boot
deleted file mode 100644
index 87811de..0000000
--- a/arch/arm/mach-u300/Makefile.boot
+++ /dev/null
@@ -1,4 +0,0 @@
-   zreladdr-y	+= 0x48008000
-params_phys-y	:= 0x48000100
-# This isn't used.
-#initrd_phys-y	:= 0x48800000
diff --git a/arch/arm/mach-ux500/Makefile.boot b/arch/arm/mach-ux500/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-ux500/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-zynq/Makefile.boot b/arch/arm/mach-zynq/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-zynq/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
-- 
1.9.1
