From: Suman Anna <s-anna@ti.com>
Subject: [RFC PATCHv2 0/3] Support for HwSpinlock reserved locks
Date: Fri, 12 Sep 2014 15:56:45 -0500
Message-ID: <1410555408-56954-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Kumar Gala <galak@codeaurora.org>
Cc: Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

This series is an RFC patchset that adds the support for reserved locks
to the HwSpinlock core to restrict the dynamic hwspin_lock_request() API
from allocating reserved locks (specific locks requested by DT client
users). The patches are split away from the v5 hwspinlock/omap dt
series [1] to not block the dt support patches. The series builds
on top of the refreshed hwspinlock core/omap dt series [2], and are
baselined on 3.17-rc3.

Following are the summary of changes:
- Patches 1 and 2 are equivalent patches of Patch 9 and 10
  from [1]. Only change is an update to hwspinlock.txt documentation.
- Patch 3 is an updated version of the reworked patch 12 [3] from v5.
  Changes include some additional function documentation, switch to
  internal of_xlate function and a fix for of_node reference maintainance.

The validation logs on all the applicable OMAP SoCs are at:
  OMAP4  - http://pastebin.ubuntu.com/8329417
  OMAP5  - http://pastebin.ubuntu.com/8329420
  DRA74x - http://pastebin.ubuntu.com/8329519
  AM33xx - http://pastebin.ubuntu.com/8329454
  AM43xx - http://pastebin.ubuntu.com/8329400

The above logs are generated with some additional test patches staged
here for reference:
https://github.com/sumananna/omap-kernel/commits/hwspinlock/test/3.17-rc3-dtv6-rsrvdlocks
https://github.com/sumananna/omap-kernel/commits/hwspinlock/submit/3.17-rc3-dtv6-rsrvdlocks

regards
Suman

[1] http://marc.info/?l=linux-arm-kernel&m=139890465902747&w=2
[2] http://marc.info/?l=linux-arm-kernel&m=141055363113881&w=2
[3] http://marc.info/?l=linux-arm-kernel&m=139968477508013&w=2

Suman Anna (3):
  hwspinlock/core: prepare unregister code to support reserved locks
  hwspinlock/core: prepare core to support reserved locks
  hwspinlock/core: add support for reserved locks

 Documentation/hwspinlock.txt             |   2 +
 drivers/hwspinlock/hwspinlock_core.c     | 108 ++++++++++++++++++++++++-------
 drivers/hwspinlock/hwspinlock_internal.h |   2 +
 3 files changed, 89 insertions(+), 23 deletions(-)

-- 
2.0.4
