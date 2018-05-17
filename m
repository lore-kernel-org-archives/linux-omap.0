From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Make sure LOGICRETSTATE bits are not cleared
Date: Thu, 17 May 2018 16:35:39 -0700
Message-ID: <20180517233542.30629-2-tony@atomide.com>
References: <20180517233542.30629-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180517233542.30629-1-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pavel Machek <pavel@ucw.cz>, Marcel Partap <mpartap@gmx.net>, Dave Gerlach <d-gerlach@ti.com>, Kalle Valo <kvalo@codeaurora.org>, Keerthy <j-keerthy@ti.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, NeKit <nekit1000@gmail.com>, Eyal Reizer <eyalr@ti.com>, Ash Charles <ash@gumstix.com>, Michael Scott <hashcode0f@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We may have LOGICRETSTATE cleared by the bootloader or kexec boot.

Currently this means we will see lost GPIO interrupts at least for
network interfaces such as wlcore and smsc911x if PER hits retention.

Let's fix the issue by making sure LOGICRETSTATE is set. Once we have
GPIOs working with wakeirqs then we should be able to clear it.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm44xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -131,6 +131,19 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 		return 0;
 	}
 
+	/*
+	 * Bootloader or kexec boot may have LOGICRETSTATE cleared
+	 * for some domains. This is the case when kexec booting from
+	 * Android kernels that support off mode for example.
+	 * Make sure it's set at least for core and per, otherwise
+	 * we currently will see lost GPIO interrupts for wlcore and
+	 * smsc911x at least if per hits retention during idle.
+	 */
+	if (!strncmp(pwrdm->name, "core", 4) ||
+	    !strncmp(pwrdm->name, "l4per", 5) ||
+	    !strncmp(pwrdm->name, "wkup", 4))
+		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
+
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
 		return -ENOMEM;
-- 
2.17.0
