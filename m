From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 8/9] ARM: OMAP3: prevent per_clkdm from attempting manual
 domain transitions
Date: Thu, 31 May 2012 16:29:01 +0300
Message-ID: <1338470942-20185-9-git-send-email-t-kristo@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Previously, PER clock domain was always enabled, as the usecounts
for this domain incorrectly always showed positive value. On HW
level though, the domain enters idle as it is set in HW supervised
mode. Now, when the usecounts reflect real values, PER domain will
attempt to enter software supervised idle, which is not supported by the
hardware/kernel that well, and causes multiple problems. First of all,
coming back from idle, PER domain remains idle as the wakedeps have
been disabled for the domain, and this causes a crash with the GPIO
code, as the resume code attempts to access domain which is not active.
Just enabling the interface clocks for the GPIO does not help, as they
are autoidled and don't bring the domain out of idle. Secondly, there
are multiple erratas for omap3, which say that the wakedeps should be
enabled for the PER domain, see e.g. errata i582 for omap3630.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index 6038adb..0dae4c8 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
 static struct clockdomain per_clkdm = {
 	.name		= "per_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_SKIP_MANUAL_TRANS,
 	.dep_bit	= OMAP3430_EN_PER_SHIFT,
 	.wkdep_srcs	= per_wkdeps,
 	.sleepdep_srcs	= per_sleepdeps,
-- 
1.7.4.1
