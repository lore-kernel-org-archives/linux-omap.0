From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V2 07/15] ARM: ks8695: cleanup cppcheck shifting error
Date: Mon, 24 Jun 2019 20:50:57 +0700
Message-ID: <20190624135105.15579-8-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-ks8695/pci.c:33]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-ks8695/regs-pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ks8695/regs-pci.h b/arch/arm/mach-ks8695/regs-pci.h
index 75a9db6edbd9..7d28a83bb574 100644
--- a/arch/arm/mach-ks8695/regs-pci.h
+++ b/arch/arm/mach-ks8695/regs-pci.h
@@ -45,9 +45,9 @@
 
 
 
-#define CFRV_GUEST		(1 << 23)
+#define CFRV_GUEST		BIT(23)
 
 #define PBCA_TYPE1		(1)
-#define PBCA_ENABLE		(1 << 31)
+#define PBCA_ENABLE		BIT(31)
 
 
-- 
2.11.0
