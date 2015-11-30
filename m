From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/7] ARM: mvebu: remove unused mach/gpio.h
Date: Tue,  1 Dec 2015 00:00:57 +0100
Message-ID: <1448924458-3279040-7-git-send-email-arnd@arndb.de>
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

This file was left over from a cleanup of asm/gpio.h and has
not been used in a while. Let's just remove it now, so the
arch/arm/mach-mvebu/include/ directory can also disappear.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mvebu/include/mach/gpio.h | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h

diff --git a/arch/arm/mach-mvebu/include/mach/gpio.h b/arch/arm/mach-mvebu/include/mach/gpio.h
deleted file mode 100644
index 40a8c178f10d..000000000000
--- a/arch/arm/mach-mvebu/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
-- 
2.1.0.rc2
