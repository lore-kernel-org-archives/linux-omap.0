From: Tony Lindgren <tony@atomide.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 10 Jul 2013 05:10:37 -0700
Message-ID: <20130710121037.GS5523@atomide.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com>
 <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55020 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753256Ab3GJMKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 08:10:42 -0400
Content-Disposition: inline
In-Reply-To: <87mwpuakod.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

* Kevin Hilman <khilman@linaro.org> [130710 01:29]:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > Hi,
> >
> > On Mon, Jul 08, 2013 at 06:50:01PM +0530, Rajendra Nayak wrote:
> >> >>>>>> I wonder if this is because the timeouts get now initialized to 0 instead
> >> >>>>>> of -1 for the serial driver?
> >> >>>>>>
> >> >>>>>
> >> >>>>> You meant initialized to -1, right? There's an additional check for timeout being 0. Unless i
> >> >>>>> am missing something DT-boot will start off with timeout set to 0 and then get forced to -1.
> >> >>>
> >> >>> OK
> >> >>
> >> >> Issue 2: Causing boot to stop when serial driver is initialized.
> >> >> (After Issue 1 is fixed)
> >> >>
> >> >> I could narrow this down to the change done to return -EINVAL
> >> >> instead of 0 in serial_omap_get_context_loss_count() as part of
> >> >> commit 'a630fbfbb1beeffc5bbe542a7986bf2068874633' "serial: omap:
> >> >> Fix device tree based PM runtime"
> >> >>
> >> >> What this change in turn seems to do is cause a
> >> >> serial_omap_restore_context() to get called as part of
> >> >> serial_omap_runtime_resume() which was not the case when
> >> >> serial_omap_get_context_loss_count() returned 0
> >> >>
> >> >> from serial_omap_runtime_resume():
> >> >> -----
> >> >>         int loss_cnt = serial_omap_get_context_loss_count(up);
> >> >>
> >> >>         if (loss_cnt < 0) {
> >> >>                 dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
> >> >>                         loss_cnt);
> >> >>                 serial_omap_restore_context(up);
> >> >>         } else if (up->context_loss_cnt != loss_cnt) {
> >> >>                 serial_omap_restore_context(up);
> >> >>         }
> >> >> -----
> >> >>
> >> >> I am still working on why a serial_omap_restore_context() could
> >> >> have caused console to die. I will work with Sourav on this and
> >> >> post the fixes for both issue 1 and issue2 once its clear on whats
> >> >> really causing issue 2.
> >> > 
> >> > That's because we don't have the omap specific pdata callbacks for
> >> > context loss any longer. We may be able to detect when the context
> >> > was really lost in the serial driver, and only then call the
> >> > serial_omap_restore_context().
> >> 
> >> Right, but calling serial_omap_restore_context() even when the context
> >> is not lost, should not ideally cause an issue.
> >
> > it does in one condition. If context hasn't been saved before. And that
> > can happen in the case of wrong pm runtime status for that device.
> >
> > Imagine the device is marked as suspended even though it's fully enabled
> > (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> > your context structure is all zeroes (context has never been saved
> > before) then when you call pm_runtime_get_sync() on probe() your
> > ->runtime_resume() will get called, which will restore context,
> > essentially undoing anything which was configured by u-boot.
> >
> > Am I missing something ?
> 
> You're right, the _set_active() is crucial in the case when we prevent
> the console UART from idling during boot (though that shouldn't be
> happening in mainline unless the fix for "Issue 1" is done.)

OK so how should we fix this?

If the problem is hwmod automatically resetting things early while
earlycon is running, then the reset should happen later.

If the problem is omap-serial.c idling things while earlycon is
running, then omap-serial.c should be fixed.

In any case we want mach-omap2/serial.c out of the way completely
for DT based booting.

Regards,

Tony
