From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Wed, 9 Jan 2019 02:42:18 +0100
Message-ID: <20190109014218.GA8363@linaro.org>
References: <20190107233833.GI5544@atomide.com>
 <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108213743.GN5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Le Tuesday 08 Jan 2019 à 13:37:43 (-0800), Tony Lindgren a écrit :
> * Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]:
> > On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote:
> > > Hmm so could it be that we now rely on timers that that may
> > > not be capable of waking up the system from idle states with
> > > hrtimer?
> > 
> > With nohz and hrtimer enabled,  timer relies on hrtimer to generate
> > the tick so you should use the same interrupt.
> 
> OK yeah looks like that part is working just fine.
> 
> Adding some printks and debugging over ssh, looks like
> omap8250_runtime_resume() gets called just fine based on a wakeirq,
> but then omap8250_runtime_suspend() runs immediately instead of
> waiting for the three second timeout.
> 
> Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> Anything higher than 2200 ms seems to somehow time out immediately
> now :)

This is quite close to the max ns of an int on arm 32bits

Could you try the patch below ?

---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..44c5c76 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
-- 
2.7.4


> 
> Regards,
> 
> Tony
