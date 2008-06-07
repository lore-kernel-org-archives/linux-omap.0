From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/02] ARM: OMAP: Correcting the gpmc prefetch control
	register address
Date: Fri,  6 Jun 2008 18:21:48 -0700
Message-ID: <1212801708-17599-3-git-send-email-tony@atomide.com>
References: <1212801708-17599-1-git-send-email-tony@atomide.com>
	<1212801708-17599-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1212801708-17599-2-git-send-email-tony@atomide.com>
Message-Id: v2.6.26-rc5-omap-fixes-2-2
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Thara Gopinath <thara@ti.com>

Correcting the GPMC_PREFETCH_CONTROL register address

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 02cede2..dbf68dc 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -42,7 +42,7 @@
 #define GPMC_STATUS		0x54
 #define GPMC_PREFETCH_CONFIG1	0x1e0
 #define GPMC_PREFETCH_CONFIG2	0x1e4
-#define GPMC_PREFETCH_CONTROL	0x1e8
+#define GPMC_PREFETCH_CONTROL	0x1ec
 #define GPMC_PREFETCH_STATUS	0x1f0
 #define GPMC_ECC_CONFIG		0x1f4
 #define GPMC_ECC_CONTROL	0x1f8

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
