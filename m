From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 07/15] ARM: ks8695: cleanup cppcheck shifting error
Date: Sun, 23 Jun 2019 22:13:05 +0700
Message-ID: <20190623151313.970-8-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-ks8695/pci.c:33]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-ks8695/regs-pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ks8695/regs-pci.h b/arch/arm/mach-ks8695/regs-pci.h
index 75a9db6edbd9..9ddab054c6fc 100644
--- a/arch/arm/mach-ks8695/regs-pci.h
+++ b/arch/arm/mach-ks8695/regs-pci.h
@@ -45,9 +45,9 @@
 
 
 
-#define CFRV_GUEST		(1 << 23)
+#define CFRV_GUEST		(1U << 23)
 
 #define PBCA_TYPE1		(1)
-#define PBCA_ENABLE		(1 << 31)
+#define PBCA_ENABLE		(1U << 31)
 
 
-- 
2.11.0
