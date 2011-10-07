From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v3] omap: dmtimer: convert printk to pr_err
Date: Fri,  7 Oct 2011 10:50:16 +0200
Message-ID: <1317977417-17874-1-git-send-email-vjaquez@igalia.com>
References: <20111006201827.GT6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111006201827.GT6324@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Timo Teras <timo.teras@solidboot.com>
List-Id: linux-omap@vger.kernel.org

Convert a printk(KERN_ERR) message in the driver to pr_err().

v2:
* Replaced dump_stack() with WARN()

v3:
* Rebased against omap/master

Signed-off-by: V=C3=ADctor Manuel J=C3=A1quez Leal <vjaquez@igalia.com>
---
 arch/arm/plat-omap/dmtimer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.=
c
index de7896f..5492ae1 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -111,7 +111,7 @@ static void omap_dm_timer_wait_for_reset(struct oma=
p_dm_timer *timer)
 	while (!(__raw_readl(timer->sys_stat) & 1)) {
 		c++;
 		if (c > 100000) {
-			printk(KERN_ERR "Timer failed to reset\n");
+			pr_err("Timer failed to reset\n");
 			return;
 		}
 	}
--=20
1.7.6.3
