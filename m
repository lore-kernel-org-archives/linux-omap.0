From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 12:34:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202031216320.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120203205401.5ddf241d@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 3 Feb 2012, NeilBrown wrote:

> On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> > On Fri, 3 Feb 2012, NeilBrown wrote:
> > 
> > > If I enable runtime pm by setting power/autosuspend_delay_ms (e.g. to 5000)
> > 
> > Runtime PM should be enabled even with power/autosuspend_delay_ms = 0.  
> > I think you are simply enabling the autosuspend timer.  There was a 
> > significant behavior change here from 3.2, I believe.
> 
> However the default autosuspend_delay_ms is "-1", not "0", and "-1" does
> disable runbtime_pm completely.  It increments usage_count (see
> update_autosuspend()) so runtime_pm can never suspend the device.

OK good, so you are indeed keeping the clocks enabled, then.

> Hmm... I thought it was the other way around - CLKEN could gate the clock
> off, and PRCM could also turn it off after a handshake.  But I finally found
> the relevant text:
> 
>    The software effect is immediate and direct. The functional clock is
>    turned on as soon as the bit is set, and turned off if the bit is cleared
>    and the clock is not required by any module.
> 
> so it seems I was wrong.

Well, one shouldn't take the TRM too seriously.  But in this case, yes I 
think you had a slightly different idea than what the hardware people
intended ;-)

> Still - something is definitely going wrong because I definitely an regularly
> see garbage characters.  And the patch fixes it.  So some runtime-suspend
> handler must be doing something bad, and it must happen while characters
> are being written.

It's certainly possible that there is another idle bug in the UART where 
it could be mistakenly idle-acking when there are bytes left to be 
transmitted.  But the patch 'tty: serial: OMAP: block idle while the UART 
is transferring data in PIO mode' should fix that.  Are you running with 
those patches applied?  Also, are you using PIO or DMA?

> > > i.e. when the tx buffer is empty, so turn the clocks off immediately, 
> > > but wait a while for the fifo to empty.  Hopefully the auto-suspend time 
> > > is enough.
> > 
> > Hmm, this statement is a little unclear to me.  The clocks won't be turned 
> > off immediately - the request to disable the clocks only happens when the 
> > autosuspend timer expires.  And even then, as mentioned above, it's just a 
> > request.  The hardware should not actually disable the functional clock 
> > until the UART FIFO is drained...
> 
> If you pm_runtime_put_autosuspend(), the suspend won't happen immediately but
> will wait the timeout.
> If you pm_runtime_put_sync(), the suspend happens straight away.
> If you pm_runtime_put(), the suspend is schedule immediately in another
> thread, so it happens very soon.  It doesn't wait for a timer to expire (no
> timer is ticking at this point).
> 
> Just because an autosuspend timeout was set earlier, that won't cause
> pm_runtime_put() to delay in suspending the device when it is called.
> 
> So I think it does request that the clocks be turned off immediately.

I was under the impression you were referring to the behavior after your 
patch was applied, rather than before it.  My misunderstanding.

> > Anyway, consider trying a different CLOCKACTIVITY setting for the UARTs. 
> 
> My TRM saids that SYSC for the UARTs doesn't have CLOCKACTIVITY. Only
>  AUTOIDLE SOFTRESET ENAWAKEUP IDLEMODE
> 
> Is it worth trying anyway?

Sure, why not.  It's fast to try, and if it happens to work, it's better 
than hacking the driver..  

> > Incidentally, I have some patches to fix the latency calculation here that 
> > are in the works, similar to the ones you describe.  The current 
> > calculation in the driver is pretty broken, but since the changes to fix 
> > the calculation are rather involved, Kevin and I thought it would be best 
> > to defer most of them to the v3.4 merge window.  The calculation fix in 
> > the 3.3-rc series is simply intended to deal with a very basic power 
> > management regression, as you know - not to make it ideal, which is more 
> > complicated.  Anyway, the patches are at git://git.pwsan.com/linux-2.6 in 
> > the branch 'omap_serial_fix_pm_qos_formula_devel_3.4'.  Keep in mind that 
> > at least one patch in that branch is broken, but perhaps you might get an 
> > idea of where they are trying to go.  Comments welcome.
> > 
> > > However I am using a lot more power than in 3.2.  
> > 
> > Is this without disabling the UART clocks?  If the driver is keeping the 
> > UART clocks enabled, then increased power consumption is definitely 
> > expected.
> 
> Both. With clocks kept on (autosuspend == -1) I'm using about 30 mA more than
> before.  With clocks allowed to go off it is closer to 40mA more !!! Weird,
> isn't it?

Interesting.  A few questions.  Do you have the PMIC and the OMAP 
configured to scale voltage in retention?  Also, does the power effect 
differ if you use different autosuspend timeouts?

> > > If I then enabled runtime_pm with a 5 second autosuspend delay:
> > >   CORE is still permanently ON (I think the USB might be doing that).
> > >   PER  is OFF (7 seconds) RET (15 seconds) and ON (8 seconds).
> > > but more surprising
> > >   MPU  is OFF (8 sec) RET (8 sec) INA (9 sec) ON (4 secs).
> > > 
> > > So we get to turn PER off at the cost of turning the MPU on a lot.
> > > (the periods in each state are only repeatable to a precision of 20%-50%).

Hmmm yeah, that does seem weird that the MPU would stay out of a low power 
state just because the autosuspend timer was enabled.  

> > > p.s. who should I formally submit OMAP-UART patches to?  I have a couple of
> > > others such as the below that I should submit somewhere.
> > 
> > Would suggest sending them to linux-serial@vger.kernel.org, 
> > linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, and Alan 
> > Cox since he is the serial maintainer?  And you should probably also cc 
> > me, since I seem to be stuck with fixing this driver so I can test my 
> > other patches; and cc Govindraj as well.
>
> Thanks for your time.

Thanks for helping us clean up this driver :-)

By the way, you might want to cc Kevin Hilman on any serial patches too, 
since he has been working in this area also.


- Paul
