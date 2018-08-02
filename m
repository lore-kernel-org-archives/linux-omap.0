From: tip-bot for Keerthy <tipbot@zytor.com>
Subject: [tip:timers/core] clocksource: ti-32k: Remove
 CLOCK_SOURCE_SUSPEND_NONSTOP flag
Date: Thu, 2 Aug 2018 04:39:52 -0700
Message-ID: <tip-c77aee71bbc67c4b0e56f4ce10406b85d4c929c1@git.kernel.org>
References: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
Reply-To: tglx@linutronix.de, grygorii.strashko@ti.com,
          linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
          tony@atomide.com, mingo@kernel.org, j-keerthy@ti.com,
          hpa@zytor.com, t-kristo@ti.com, d-gerlach@ti.com,
          daniel.lezcano@linaro.org, linux-omap@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533191716-20476-1-git-send-email-j-keerthy@ti.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: j-keerthy@ti.com, hpa@zytor.com, linux-omap@vger.kernel.org, t-kristo@ti.com, daniel.lezcano@linaro.org, d-gerlach@ti.com, grygorii.strashko@ti.com, tglx@linutronix.de, tony@atomide.com, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, mingo@kernel.org
List-Id: linux-omap@vger.kernel.org

Commit-ID:  c77aee71bbc67c4b0e56f4ce10406b85d4c929c1
Gitweb:     https://git.kernel.org/tip/c77aee71bbc67c4b0e56f4ce10406b85d4c929c1
Author:     Keerthy <j-keerthy@ti.com>
AuthorDate: Thu, 2 Aug 2018 12:05:16 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 13:35:08 +0200

clocksource: ti-32k: Remove CLOCK_SOURCE_SUSPEND_NONSTOP flag

Since commit 39232ed5a179 ("time: Introduce one suspend clocksource to
compensate the suspend time") suspend/resume fails on AM437x platforms as
the clocksource actually stops in suspend.

Hence remove the CLOCK_SOURCE_SUSPEND_NONSTOP flag.

Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <daniel.lezcano@linaro.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <baolin.wang@linaro.org>
Cc: <d-gerlach@ti.com>
Cc: <tony@atomide.com>
Cc: <t-kristo@ti.com>
Link: https://lkml.kernel.org/r/1533191716-20476-1-git-send-email-j-keerthy@ti.com

---
 drivers/clocksource/timer-ti-32k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861ab3c8..29e2e1a78a43 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -78,8 +78,7 @@ static struct ti_32k ti_32k_timer = {
 		.rating		= 250,
 		.read		= ti_32k_read_cycles,
 		.mask		= CLOCKSOURCE_MASK(32),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS |
-				CLOCK_SOURCE_SUSPEND_NONSTOP,
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	},
 };
 
