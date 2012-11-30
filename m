From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/3] omap late timer clean-up (and a warning fix) for
 v3.8 merge window
Date: Thu, 29 Nov 2012 23:18:33 -0800
Message-ID: <20121130071833.GD6899@quad.lixom.net>
References: <50b41207.c188e50a.6d1e.ffffd469SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <50b41207.c188e50a.6d1e.ffffd469SMTPIN_ADDED_BROKEN@mx.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Igor Grinberg <grinberg@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 26, 2012 at 05:06:11PM -0800, Tony Lindgren wrote:
> The following changes since commit 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:
> 
>   Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-timer-signed
> 
> for you to fetch changes up to 26f01998b0657a61167a819f1c37cb9f9e9d674b:
> 
>   ARM: OMAP3: cm-t3517: use GPTIMER for system clock (2012-11-21 10:20:43 -0800)

By the way, I had to apply the following fixup on top of this (in next/cleanup)
to fix a compilation failure. Seems to be caused by "ARM: OMAP2+: timer: remove
CONFIG_OMAP_32K_TIMER" from Igor.

Also, add __init annotation to remove 12 section mismatches (and take off the
explicit inline since __init + inline doesn't make sense -- the compiler should
do the right thing anyway).

-Olof

>From 73f14f6d007df1596da7cea9113084acfe846b8f Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Thu, 29 Nov 2012 23:05:32 -0800
Subject: [PATCH] ARM: omap: fix typo on timer cleanup

Fix 32 vs 32k typo:

arch/arm/mach-omap2/timer.c: In function 'omap4_local_timer_init':
arch/arm/mach-omap2/timer.c:633:2: error: implicit declaration of function 'omap4_sync32_timer_init' [-Werror=implicit-function-declaration]
arch/arm/mach-omap2/timer.c: At top level:
arch/arm/mach-omap2/timer.c:610:2: warning: 'omap4_sync32k_timer_init' defined but not used [-Wunused-function]

Also, mark the omap4_local_timer_init() stub as __init (and take off
the explicit inline and let the compiler do the work instead).

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b9cff72..7016637 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -628,9 +628,9 @@ static void __init omap4_local_timer_init(void)
 	}
 }
 #else /* CONFIG_LOCAL_TIMERS */
-static inline void omap4_local_timer_init(void)
+static void __init omap4_local_timer_init(void)
 {
-	omap4_sync32_timer_init();
+	omap4_sync32k_timer_init();
 }
 #endif /* CONFIG_LOCAL_TIMERS */
 OMAP_SYS_TIMER(4, local);
-- 
1.7.10.1.488.g05fbf7a
