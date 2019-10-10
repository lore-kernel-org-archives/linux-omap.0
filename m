From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] ARM: OMAP2+: Allow core oswr for omap4
Date: Wed,  9 Oct 2019 17:12:23 -0700
Message-ID: <20191010001224.41826-8-tony@atomide.com>
References: <20191010001224.41826-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010001224.41826-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Commit f74297dd9354 ("ARM: OMAP2+: Make sure LOGICRETSTATE bits are not
cleared") disabled oswr (open switch retention) for per and core domains
as various GPIO related issues were noticed if the bootloader had
configured the bits for LOGICRETSTATE for per and core domains.

With the recent gpio-omap fixes, mostly related to commit e6818d29ea15
("gpio: gpio-omap: configure edge detection for level IRQs for idle
wakeup"), things now behave for enabling core oswr for omap4.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm44xx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -128,18 +128,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 		return 0;
 	}
 
-	/*
-	 * Bootloader or kexec boot may have LOGICRETSTATE cleared
-	 * for some domains. This is the case when kexec booting from
-	 * Android kernels that support off mode for example.
-	 * Make sure it's set at least for core and per, otherwise
-	 * we currently will see lost GPIO interrupts for wlcore and
-	 * smsc911x at least if per hits retention during idle.
-	 */
-	if (!strncmp(pwrdm->name, "core", 4)
-		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
-
-	if (!strncmp(pwrdm->name, "l4per", 5)
+	if (!strncmp(pwrdm->name, "core", 4) ||
+	    !strncmp(pwrdm->name, "l4per", 5))
 		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);
 
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
-- 
2.23.0
