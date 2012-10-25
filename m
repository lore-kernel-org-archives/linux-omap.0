From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH V3 1/5] ARM: dts: OMAP: Add timer nodes
Date: Thu, 25 Oct 2012 15:51:29 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB4AB84@DBDE01.ent.ti.com>
References: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
 <1350496873-21337-2-git-send-email-jon-hunter@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB49C1B@DBDE01.ent.ti.com>
 <50887315.2000509@ti.com>
 <79CD15C6BA57404B839C016229A409A83EB4A768@DBDE01.ent.ti.com>
 <50892E27.7070102@ti.com> <508931A1.50608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755057Ab2JYPvn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 11:51:43 -0400
In-Reply-To: <508931A1.50608@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 25, 2012 at 18:03:37, Hunter, Jon wrote:
> 
> On 10/25/2012 07:18 AM, Jon Hunter wrote:
> 
> ...
> 
> >> @@ -113,6 +114,9 @@ static int omap_timer_interrupt_test(struct omap_dm_timer *gptimer)
> >>
> >>         irq_data.gptimer = gptimer;
> >>         init_completion(&irq_data.complete);
> >> +
> >> +       omap_dm_timer_enable(gptimer);
> >> +
> >>         omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);
> >>         omap_dm_timer_set_load_start(gptimer, 0, 0xffffff00);
> >>
> >> @@ -128,6 +132,8 @@ static int omap_timer_interrupt_test(struct omap_dm_timer *gptimer)
> >>
> >>         omap_dm_timer_stop(gptimer);
> >>         omap_dm_timer_set_int_enable(gptimer, 0);
> >> +       omap_dm_timer_disable(gptimer);
> >> +
> > 
> > Hmmm ... I am wondering if there is another bug lingering in the dmtimer
> > driver. Ideally, the context should be preserved by the driver.
> 
> Looking at omap_dm_timer_set_load_start() we have the following code to
> restore context ...
> 
> if (!(timer->capability & OMAP_TIMER_ALWON)) {
> 	if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
> 			timer->ctx_loss_count)		
> 		omap_timer_restore_context(timer);
> }
> 
> Can you see if this is getting called for AM33xx for the failing timers?
> If not then it would suggest that we are not detecting context loss
> correctly and not restoring the context. With the above context restore
> code we should not need those extra omap_dm_timer_enable/disable calls.
> 

OK, below log explains all now,

----------------------
Testing 48042000.timer with 24000000 Hz clock ...
omap_dm_timer_set_load_start:559 ctx_loss_count - 0, get_dev_context - 0
Timer read test PASSED! No errors, 100 loops
omap_dm_timer_set_int_enable:665: irq_ena - 0
omap_dm_timer_set_int_enable:671: irq_ena - 2
omap_dm_timer_set_load_start:559 ctx_loss_count - 0, get_dev_context - 0
Timer interrupt test FAILED! No interrupt occurred in 1 sec
omap_dm_timer_set_int_enable:665: irq_ena - 0
omap_dm_timer_set_int_enable:671: irq_ena - 0
Testing 48042000.timer with 32768 Hz clock ...
omap_dm_timer_set_load_start:559 ctx_loss_count - 0, get_dev_context - 0
----------------------


So below condition is not passing for AM33xx which results into context loss.

if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
                                 timer->ctx_loss_count)


Let me debug on this, this looks something specific to am33xx missing from 
baseport.

Thanks,
Vaibhav

