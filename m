From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: v4.9 to v4.10 regression: oops when USB cable is plugged in.
Date: Tue, 24 Jan 2017 11:01:33 +0100
Message-ID: <20170124100133.GA21079@pali>
References: <20170123222537.GA11543@amd>
 <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124091817.GA29246@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, b-liu@ti.com, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 24 January 2017 10:18:17 Pavel Machek wrote:
> Hi!
> On Mon 2017-01-23 14:44:54, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [170123 14:26]:
> > > [25392.239837] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> > > [25392.239868] pgd = c0004000
> > > [25392.239898] [fa0ab060] *pgd=48011452(bad)
> > > [25392.239929] Internal error: : 1028 [#1] ARM
> > > [25392.239929] Modules linked in:
> > > [25392.239959] CPU: 0 PID: 24322 Comm: kworker/0:1 Not tainted 4.10.0-rc5-142127-g41f2839-dirty #222
> > > [25392.239990] Hardware name: Nokia RX-51 board
> > > [25392.240020] Workqueue: events musb_irq_work
> > > [25392.240051] task: cd44d5c0 task.stack: cd308000
> > > [25392.240051] PC is at musb_default_readb+0x0/0xc
> > > [25392.240081] LR is at musb_irq_work+0x1c/0x1b0
> > 
> > OK I'm pretty sure the patch I posted few days ago fixes
> > this. Can you please test patch "[PATCH] usb: musb: Fix
> > external abort on non-linefetch for musb_irq_work()"?
> 
> Can I get the copy of the patch?
> 
> http://www.spinics.net/lists/linux-usb/msg152542.html
> 
> ...but it is html mangled with no obvious way to unmangle it.

Another place when caller of pm_runtime_get_sync forgot to check return
value? This is not first time I see this problem related to Nokia N900!

In past I already suggested to use gcc attribute for pm_runtime_get_sync
to issue warning when caller does not check return value.

> > I was able to hit that only once so far, do you hit it
> > every time with your built-in g_ether .config?
> 
> I get it "way too often", like once a day. I don't yet know how to hit
> it reliably :-(.

-- 
Pali Rohár
pali.rohar@gmail.com
