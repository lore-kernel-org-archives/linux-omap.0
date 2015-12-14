From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 2/2] arm: omap2: AM43xx: select ARM TWD timer
Date: Mon, 14 Dec 2015 22:34:06 +0200
Message-ID: <1450125246-17249-3-git-send-email-grygorii.strashko@ti.com>
References: <1450125246-17249-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450125246-17249-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

Make sure to tell the kernel that AM437x devices have ARM TWD timer.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[grygorii.strashko@ti.com: drop ARM Global timer selection, because
 it's incompatible with PM (cpuidle/cpufreq). So, it's unsafe to enable
 it unconditionally]
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
v1: http://www.spinics.net/lists/arm-kernel/msg459649.html

 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 32a0086..0517f0c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -66,6 +66,7 @@ config SOC_AM43XX
 	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select HAVE_ARM_TWD
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.6.4
