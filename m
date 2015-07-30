From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable/v4.0] ARM: OMAP3: Fix booting with thumb2 kernel
Date: Thu, 30 Jul 2015 13:43:44 -0700
Message-ID: <20150730204344.GA751@kroah.com>
References: <1436542126-2634-1-git-send-email-khilman@kernel.org>
 <CAMAWPa-sC7q+vAob-ce2_ubZCvfkKRA9m2bs2CAsP3p6zLFOtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMAWPa-sC7q+vAob-ce2_ubZCvfkKRA9m2bs2CAsP3p6zLFOtw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 30, 2015 at 03:27:54PM -0500, Kevin Hilman wrote:
> Hi Greg,
> 
> On Fri, Jul 10, 2015 at 10:28 AM, Kevin Hilman <khilman@kernel.org> wrote:
> > From: Tony Lindgren <tony@atomide.com>
> >
> > We get a NULL pointer dereference on omap3 for thumb2 compiled kernels:
> >
> > Internal error: Oops: 80000005 [#1] SMP THUMB2
> > ...
> > [<c046497b>] (_raw_spin_unlock_irqrestore) from [<c0024375>]
> > (omap3_enter_idle_bm+0xc5/0x178)
> > [<c0024375>] (omap3_enter_idle_bm) from [<c0374e63>]
> > (cpuidle_enter_state+0x77/0x27c)
> > [<c0374e63>] (cpuidle_enter_state) from [<c00627f1>]
> > (cpu_startup_entry+0x155/0x23c)
> > [<c00627f1>] (cpu_startup_entry) from [<c06b9a47>]
> > (start_kernel+0x32f/0x338)
> > [<c06b9a47>] (start_kernel) from [<8000807f>] (0x8000807f)
> >
> > The power management related assembly on omaps needs to interact with
> > ARM mode bootrom code, so we need to keep most of the related assembly
> > in ARM mode.
> >
> > Turns out this error is because of missing ENDPROC for assembly code
> > as suggested by Stephen Boyd <sboyd@codeaurora.org>. Let's fix the
> > problem by adding ENDPROC in two places to sleep34xx.S.
> >
> > Let's also remove the now duplicate custom code for mode switching.
> > This has been unnecessary since commit 6ebbf2ce437b ("ARM: convert
> > all "mov.* pc, reg" to "bx reg" for ARMv6+").
> >
> > And let's also remove the comments about local variables, they are
> > now just confusing after the ENDPROC.
> >
> > The reason why ENDPROC makes a difference is it sets .type and then
> > the compiler knows what to do with the thumb bit as explained at:
> >
> > https://wiki.ubuntu.com/ARM/Thumb2PortingHowto
> >
> > Reported-by: Kevin Hilman <khilman@kernel.org>
> > Tested-by: Kevin Hilman <khilman@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > (cherry picked from commit d8a50941c91a68da202aaa96a3dacd471ea9c693)
> > Cc: <stable@vger.kernel.org> # v4.0+
> > Signed-off-by: Kevin Hilman <khilman@linaro.org>
> 
> This  one seems to be missing in v4.0.9, though it was submitted ~10
> days before.  I missed noticing it was not present in the stable queue
> because I've been on vacation.
> 
> I know you mentioned you were wrapping up v4.0, but any chance of this
> being included?

There isn't going to be any more 4.0-stable releases, sorry, so it
doesn't really matter as everyone should be on 4.1 by now :)

thanks,

greg k-h
