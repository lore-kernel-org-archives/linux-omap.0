From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap2: Kconfig: select TWD and global timer on AM43xx
 devices
Date: Thu, 12 Nov 2015 12:06:06 -0600
Message-ID: <1447351566-2328-1-git-send-email-balbi@ti.com>
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
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Make sure to tell the kernel that AM437x has
TWD and global timers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Hi Tony,

now that all dependencies are in place, we can
finally enable twd and global_timer for AM437x.

cheers

 arch/arm/mach-omap2/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5076d3f334d2..bb3daf0fa7f7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,9 @@ config SOC_AM43XX
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select ARM_GLOBAL_TIMER
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.6.2
