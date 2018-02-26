From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: omap2: set CONFIG_LIRC=y in defconfig
Date: Mon, 26 Feb 2018 21:40:52 +0100
Message-ID: <20180226204105.2858838-1-arnd@arndb.de>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Sean Young <sean@mess.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The CONFIG_LIRC symbol has changed from 'tristate' to 'bool, so we now
get a warning for omap2plus_defconfig:

arch/arm/configs/omap2plus_defconfig:322:warning: symbol value 'm' invalid for LIRC

This changes the file to mark the symbol as built-in to get rid of the
warning.

Fixes: a60d64b15c20 ("media: lirc: lirc interface should not be a raw decoder")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 2f145c4af93a..92674f247a12 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -319,7 +319,7 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_RC_CORE=m
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
-CONFIG_LIRC=m
+CONFIG_LIRC=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_RX51=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-- 
2.9.0
