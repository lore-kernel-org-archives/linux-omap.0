From: Ido Yariv <ido@wizery.com>
Subject: [PATCH] hwspinlock/core: Fix unbalanced module_get on error path
Date: Wed, 12 Dec 2012 22:24:57 +0200
Message-ID: <1355343897-17063-1-git-send-email-ido@wizery.com>
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
To: Ohad Ben-Cohen <ohad@wizery.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>
List-Id: linux-omap@vger.kernel.org

In case pm_runtime_get_sync() fails, __hwspin_lock_request will exit
without calling module_put. As a result, the module could never be
removed. Fix this.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/hwspinlock/hwspinlock_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index db713c0..085e28e 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -415,6 +415,7 @@ static int __hwspin_lock_request(struct hwspinlock *hwlock)
 	/* notify PM core that power is now needed */
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
+		module_put(dev->driver->owner);
 		dev_err(dev, "%s: can't power on device\n", __func__);
 		return ret;
 	}
-- 
1.7.7.6
