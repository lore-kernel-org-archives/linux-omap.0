From: Todd Poynor <tpoynor@mvista.com>
Subject: OMAP touchscreen timer BUG
Date: Mon, 12 Dec 2005 18:29:05 -0800
Message-ID: <20051213022905.GA27130@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

kernel BUG at include/linux/timer.h:83!
[<c002ac60>] (__bug+0x0/0x58) from [<c01a3fbc>] (omap_ts_handler+0x60/0x78)
[<c01a3f5c>] (omap_ts_handler+0x0/0x78) from [<c00269fc>] (__do_irq+0x4c/0x8c)

which is:

static inline void add_timer(struct timer_list *timer)
{
        BUG_ON(timer_pending(timer));
        __mod_timer(timer, timer->expires);


--- cut here ---
Fix OMAP touchscreen timer restart BUG.

Signed-off-by: Todd Poynor <tpoynor@mvista.com>

---
commit 8535b0415fd850100b2b5ed791faf686d914ac8d
tree 96818d12a79471e6d0fd12fbec865cf34f2fd5ac
parent f099b9f4e63772a8e072f5957fe549354c41c09b
author Todd Poynor <tpoynor@mvista.com> Mon, 12 Dec 2005 18:24:26 -0800
committer Todd Poynor <tpoynor@mvista.com> Mon, 12 Dec 2005 18:24:26 -0800

 drivers/input/touchscreen/omap/omap_ts.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/omap/omap_ts.c b/drivers/input/touchscreen/omap/omap_ts.c
index 64b2738..3b13c0d 100644
--- a/drivers/input/touchscreen/omap/omap_ts.c
+++ b/drivers/input/touchscreen/omap/omap_ts.c
@@ -120,8 +120,7 @@ static irqreturn_t omap_ts_handler(int i
 		disable_irq(irq);
 	}
 	// restart acquire
-	ts_omap.ts_timer.expires = jiffies + HZ / 100;
-	add_timer(&(ts_omap.ts_timer));
+	mod_timer(&ts_omap.ts_timer, jiffies + HZ / 100);
 
 	spin_unlock(&ts_omap.lock);
 
