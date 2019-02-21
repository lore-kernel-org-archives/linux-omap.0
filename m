From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] phy: phy-twl4030-usb: fix denied runtime access
Date: Thu, 21 Feb 2019 13:27:49 -0800
Message-ID: <20190221212749.GZ15711@atomide.com>
References: <20180922094405.4067-1-andreas@kemnade.info>
 <20190220223132.GV15711@atomide.com>
 <20190221170840.5c970def@kemnade.info>
 <20190221164803.GX15711@atomide.com>
 <20190221203958.66d904f6@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221203958.66d904f6@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190221 19:40]:
> On Thu, 21 Feb 2019 08:48:03 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [190221 16:43]:
> > > Hi,
> > > 
> > > On Wed, 20 Feb 2019 14:31:32 -0800
> > > Tony Lindgren <tony@atomide.com> wrote:
> > >   
> > > > * Andreas Kemnade <andreas@kemnade.info> [180922 09:48]:  
> > > > > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > > > > the counter will be incremented but the resume callback not called,
> > > > > so enumeration and charging will not start properly.
> > > > > To avoid that happen, disable irq on suspend and recheck on resume.
> > > > > 
> > > > > Practically this happens when the device is woken up from suspend by
> > > > > plugging in usb.
> > > > > 
> > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > ---
> > > > > Changes in v2:
> > > > > * use pm suspend/resume callback instead of delayed_work
> > > > >   as suggested by Dmitry    
> > > > 
> > > > Hmm it just occurred to me that this issue too might be fixed with commit
> > > > c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device
> > > > for suspend"). Andreas, care to check? That is if this is still an
> > > > issue.
> > > >   
> > > this one made already its way into 4.20. But for the records, I will
> > > build the latest 5.0-rc and revert it and will check if the problem
> > > still occurs.  
> > 
> > OK thanks.
> > 
> first of all, suspend is totally broken in v5.0-rc7.
> I booted with init=/bin/bash
> and just loaded gpio-twl4030 and twl4030-pwrbutton
> 
> and did (rtc in compiled in) a
>  root@(none):/# rtcwake -s 10 -m mem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Jan  1 00:05:24 2000
> [   86.434722] PM: suspend entry (deep)
> [   86.438842] PM: Syncing filesystems ... done.
> [   86.458770] Freezing user space processes ... (elapsed 0.003 seconds) done.
> [   86.470947] OOM killer disabled.
> [   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   86.485473] printk: Suspending console(s) (use no_console_suspend to debug)
> [   86.555572] Disabling non-boot CPUs ...
> [   86.555664] Successfully put all powerdomains to target state
> [   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563751] twl4030: I2C error -13 reading PIH ISR
> [   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563812] twl4030: I2C error -13 reading PIH ISR
> [   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
> [   86.563903] twl4030: I2C error -13 reading PIH ISR
> 
> and this goes on forever.
> I will try to bisect that.

Strange, I'm not seeing that here. Anyways let's debug more
in your bisect email thread.

Thanks,

Tony
