From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V2 13/15] ARM: mm: cleanup cppcheck shifting errors
Date: Mon, 24 Jun 2019 20:51:03 +0700
Message-ID: <20190624135105.15579-14-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

[arch/arm/mm/alignment.c:875]: (error) Shifting signed 32-bit value by
31 bits is undefined behaviour
[arch/arm/mm/fault.c:556]: (error) Shifting signed 32-bit value by 31
bits is undefined behaviour
[arch/arm/mm/fault.c:585]: (error) Shifting signed 32-bit value by 31
bits is undefined behaviour
[arch/arm/mm/fault.c:219]: (error) Shifting signed 32-bit value by 31
bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mm/fault.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index c063708fa503..8a706cb7f21d 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -5,9 +5,9 @@
 /*
  * Fault status register encodings.  We steal bit 31 for our own purposes.
  */
-#define FSR_LNX_PF		(1 << 31)
-#define FSR_WRITE		(1 << 11)
-#define FSR_FS4			(1 << 10)
+#define FSR_LNX_PF		BIT(31)
+#define FSR_WRITE		BIT(11)
+#define FSR_FS4			BIT(10)
 #define FSR_FS3_0		(15)
 #define FSR_FS5_0		(0x3f)
 
-- 
2.11.0
