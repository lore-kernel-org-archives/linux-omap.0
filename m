From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] ARM: OMAP: PM: Drop useless checks for PM_SUSPEND_STANDBY
Date: Fri, 17 Feb 2017 17:10:35 +0100
Message-ID: <1487347836-14427-3-git-send-email-geert+renesas@glider.be>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Dinh Nguyen <dinguyen@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-omap@vger.kernel.org

As OMAP uses the standard suspend_valid_only_mem() for its
platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
callback will never be called with state equal to PM_SUSPEND_STANDBY.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-omap1/pm.c | 1 -
 arch/arm/mach-omap2/pm.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index ee5460b8ec2ee6e9..f1135bf8940ed82d 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -581,7 +581,6 @@ static int omap_pm_enter(suspend_state_t state)
 {
 	switch (state)
 	{
-	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
 		omap1_pm_suspend();
 		break;
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 0598630c17786242..63027e60cc209f1c 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -163,7 +163,6 @@ static int omap_pm_enter(suspend_state_t suspend_state)
 		return -ENOENT; /* XXX doublecheck */
 
 	switch (suspend_state) {
-	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
 		ret = omap_pm_suspend();
 		break;
-- 
1.9.1
