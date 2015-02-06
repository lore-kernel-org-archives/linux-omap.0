From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM: omap2+: omap_hwmod: Fix false lockdep warning
Date: Fri, 6 Feb 2015 14:48:34 +0200
Message-ID: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

In case when hwmods are used in nested way the lockdep validator will print out
a warning message about possible deadlock situation:

[    4.514882] =============================================
[    4.520530] [ INFO: possible recursive locking detected ]
[    4.526176] 3.14.30-00289-ge44872fdca8f-dirty #198 Not tainted
[    4.532285] ---------------------------------------------
[    4.537936] kworker/u4:1/18 is trying to acquire lock:
[    4.543317]  (&(&oh->_lock)->rlock){......}, at: [<c002d2dc>] omap_hwmod_enable+0x2c/0x58
[    4.552109] 
[    4.552109] but task is already holding lock:
[    4.558216]  (&(&oh->_lock)->rlock){......}, at: [<c002d2dc>] omap_hwmod_enable+0x2c/0x58
[    4.566999] 
[    4.566999] other info that might help us debug this:
[    4.573831]  Possible unsafe locking scenario:
[    4.573831] 
[    4.580025]        CPU0
[    4.582584]        ----
[    4.585142]   lock(&(&oh->_lock)->rlock);
[    4.589544]   lock(&(&oh->_lock)->rlock);
[    4.593945] 
[    4.593945]  *** DEADLOCK ***
[    4.593945] 
[    4.600146]  May be due to missing lock nesting notation

What lockdep did not realizes is that the two oh is not the same hwmod object
and we have taken different locks.

One example of nested hwmod usage is on DRA7xx platforms, where McASP can be
configured to use ATL clock as it's functional clock. In this case the
pm_runtime_get/put_sync call will enable the mcasp hwmod and as part of this
operation it will enable the needed clocks. Since ATL clock is needed, we will
have another pm_runtime operation from the ATL clock enable callback which
will take the atl hwmod's lock. This will be seen by lockdep as possible
deadlock situation.

In order to notify lockdep about this, we need to switch using _nested
version of locking function and assign different subclass to those hwmods which
could be used in nested way.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: omap2+: omap_hwmod: Use _nested version of spinlock for oh->_lock
  ARM: DRA7: hwmod_data: Change locked_class for atl hwmod

 arch/arm/mach-omap2/omap_hwmod.c          | 16 ++++++++--------
 arch/arm/mach-omap2/omap_hwmod.h          |  5 +++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.2.2
