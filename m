From: Majunath Goudar <csmanjuvijay@gmail.com>
Subject: [PATCH] ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations.
Date: Tue,  8 Oct 2013 15:59:01 +0530
Message-ID: <1381228141-16213-1-git-send-email-csmanjuvijay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: nataraja.km@lge.com, Majunath Goudar <csmanjuvijay@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch adds a omap1510_fpga_init_irq() inline dummy implementations
in arch/arm/mach-omap1/common.h. Without this patch,build system can
lead to issues. This was discovered during randconfig testing,in which
other than CONFIG_ARCH_OMAP15XX was enabled the leading to the followin=
g
error:

CC      arch/arm/mach-omap1/board-innovator.o
arch/arm/mach-omap1/board-innovator.c: In function =E2=80=98innovator_i=
nit=E2=80=99:
arch/arm/mach-omap1/board-innovator.c:377:3: error: implicit declaratio=
n of
function =E2=80=98omap1510_fpga_init_irq=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-omap1/board-innovator.o] Error 1
make: *** [arch/arm/mach-omap1] Error 2

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
---
 arch/arm/mach-omap1/common.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.=
h
index abec019..732f8ee 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -46,6 +46,9 @@ static inline void omap7xx_map_io(void)
 void omap1510_fpga_init_irq(void);
 void omap15xx_map_io(void);
 #else
+static inline void omap1510_fpga_init_irq(void)
+{
+}
 static inline void omap15xx_map_io(void)
 {
 }
--=20
1.7.9.5
