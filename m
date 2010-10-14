From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] arm: perf: Fix build break due to a typo
Date: Thu, 14 Oct 2010 20:04:01 +0530
Message-ID: <1287066841-28569-1-git-send-email-gadiyar@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Tony Lindgren <tony@atomide.com>, paulus <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Anand Gadiyar <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

armpmu is a pointer to a structure - We need to use the
structure pointer operator to access num_events, and not
the structure member operator.

This fixes the following build break when building for OMAP4.

  CC      arch/arm/kernel/perf_event.o
arch/arm/kernel/perf_event.c: In function 'armpmu_event_init':
arch/arm/kernel/perf_event.c:543: error: request for member 'num_events' in something not a structure or union
make[1]: *** [arch/arm/kernel/perf_event.o] Error 1
make: *** [arch/arm/kernel] Error 2

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: paulus <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
This break is reproducible on linux-next as of 20101014.

This was introduced in commit 15ac9a395a75 in linux-next
<http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commitdiff;h=15ac9a395a753cb28c674e7ea80386ffdff21785>

Strangely, I did not catch it with a standard omap2plus_defconfig
build, but it showed up when I build a custom OMAP4-only config.
I've saved the defconfig for later analysis.

 arch/arm/kernel/perf_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: mainline/arch/arm/kernel/perf_event.c
===================================================================
--- mainline.orig/arch/arm/kernel/perf_event.c
+++ mainline/arch/arm/kernel/perf_event.c
@@ -540,7 +540,7 @@ static int armpmu_event_init(struct perf
 	event->destroy = hw_perf_event_destroy;
 
 	if (!atomic_inc_not_zero(&active_events)) {
-		if (atomic_read(&active_events) > armpmu.num_events) {
+		if (atomic_read(&active_events) > armpmu->num_events) {
 			atomic_dec(&active_events);
 			return -ENOSPC;
 		}
