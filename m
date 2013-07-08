From: Tony Lindgren <tony@atomide.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Mon, 8 Jul 2013 06:10:33 -0700
Message-ID: <20130708131033.GA5523@atomide.com>
References: <51D577E6.5010507@newflow.co.uk>
 <51D59146.3070002@newflow.co.uk>
 <51D59C0E.8080003@newflow.co.uk>
 <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com>
 <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38071 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab3GHNKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jul 2013 09:10:38 -0400
Content-Disposition: inline
In-Reply-To: <51DAB394.3050104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>

* Rajendra Nayak <rnayak@ti.com> [130708 05:48]:
> On Monday 08 July 2013 04:55 PM, Tony Lindgren wrote:
> > * Bedia, Vaibhav <vaibhav.bedia@ti.com> [130705 06:37]:
> >> On Fri, Jul 05, 2013 at 18:50:10, Bedia, Vaibhav wrote:
> >>> Hi Tony,
> >>>
> >>> On Fri, Jul 05, 2013 at 17:29:59, Tony Lindgren wrote:
> >>>> * Bedia, Vaibhav <vaibhav.bedia@ti.com> [130705 01:17]:
> >>>>>
> >>>>> I just checked the behavior on my AM335x-EVM. Current mainline boots fine
> >>>>> provided I don't use earlyprintk.  The offending patch [1] in this case is the one
> >>>>> that tries to get rid of omap_serial_early_init() for DT boot. This change inadvertently
> >>>>> also results in the console UART getting reset and idled during bootup and that's where
> >>>>> the boot stops for you. I think if you skip earlyprintk from the bootargs you should see
> >>>>> the system booting fine. 
> >>>>>
> >>>>> I guess we need to retain the NO_IDLE and NO_RESET aspect for the console UART in
> >>>>> omap_serial_early_init() to get earlyprintk working again.
> >>>>
> >>>> Hmm nothing should get idled while earlyprintk is running, and then when the
> >>>> serial driver kicks in it should not idle anything by default. And for DT based
> >>>> booting we should not have mach-omap2/serial.c initialize anything.
> >>>>
> >>>
> >>> If I add in the HWMOD flags without any reverts I get to the point where the serial driver
> >>> comes up but the boot eventually stops [1]. Without the flags the boot stops much earlier [2]
> >>> just like Mark reported.
> >>>
> >>
> >> Err.. the log with HWMOD flags added is [2] and without flags is [1]. Sorry for the confusion.
> > 
> > It sounds like something needs to be fixed for am33xx as omap3 and omap4
> > won't hang with earlyprintk. Almost certainly mach-omap2/serial.c should not
> > be needed at all for am33xx, and the bug is somewhere else.
> 
> Tony, I spent some time on this today and there seem to 2 issues.
> 
> Issue 1: Causing boot to stop much earlier as reported (this is during hmwod setup)
> 
> The commit 'e97f03cb36e9ec8a2ccaa3e4bee5297fe48156fd' 
> "ARM: OMAP2+: Fix serial init for device tree based booting" stubbed out omap_serial_early_init()
> for DT case thinking its doing the port inits. But that does not seem to be true, the port inits happen
> as part of omap_serial_init_port(). What omap_serial_early_init() was doing instead was adding the
> HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags which would tell hmwod not to reset and then idle the
> console UART. With this not happening now for the DT case, it causes an issue.
> 
> The issue was seen on am33xx and not on some other platforms because some platforms still have these
> statically defined in the hwmod data files. I could see these set for uart3 in case of omap4 and omap5.
> So I feel the above commit should be reverted and these static flags should be removed from the data
> files.

Oh OK. That's starting to make a bit more sense then. 
  
> >>>> I wonder if this is because the timeouts get now initialized to 0 instead
> >>>> of -1 for the serial driver?
> >>>>
> >>>
> >>> You meant initialized to -1, right? There's an additional check for timeout being 0. Unless i
> >>> am missing something DT-boot will start off with timeout set to 0 and then get forced to -1.
> > 
> > OK
> 
> Issue 2: Causing boot to stop when serial driver is initialized. (After Issue 1 is fixed)
> 
> I could narrow this down to the change done to return -EINVAL instead of 0 in serial_omap_get_context_loss_count()
> as part of commit 'a630fbfbb1beeffc5bbe542a7986bf2068874633' "serial: omap: Fix device tree based PM runtime"
> 
> What this change in turn seems to do is cause a serial_omap_restore_context() to get called as part of
> serial_omap_runtime_resume() which was not the case when serial_omap_get_context_loss_count() returned 0
> 
> from serial_omap_runtime_resume():
> -----
>         int loss_cnt = serial_omap_get_context_loss_count(up);
> 
>         if (loss_cnt < 0) {
>                 dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
>                         loss_cnt);
>                 serial_omap_restore_context(up);
>         } else if (up->context_loss_cnt != loss_cnt) {
>                 serial_omap_restore_context(up);
>         }
> -----
> 
> I am still working on why a serial_omap_restore_context() could have caused console to die. I will work with
> Sourav on this and post the fixes for both issue 1 and issue2 once its clear on whats really causing issue 2.

That's because we don't have the omap specific pdata callbacks for
context loss any longer. We may be able to detect when the context
was really lost in the serial driver, and only then call the
serial_omap_restore_context().
 
> Let me know if the fix I listed for Issue 1: makes sense.

Yes makes sense as a fix, but IMHO we should not need any workarounds
like that. Is the hwmod code idling the the uarts early? If so, then
it should only do that in a late_initcall if no drivers are registered.

Regards,

Tony
