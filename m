From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
Date: Tue, 25 Jul 2017 01:56:18 -0700
Message-ID: <20170725085617.GR10026@atomide.com>
References: <20170724095201.21601-1-johan@kernel.org>
 <05ae4585-8da0-6fb1-8cfd-6b236ec3a8a2@ti.com>
 <20170725071048.GP10026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725071048.GP10026@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Dave Gerlach <d-gerlach@ti.com>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170725 00:11]:
> * Grygorii Strashko <grygorii.strashko@ti.com> [170724 15:17]:
> > My personal thought here is that removing of pm_runtime_set_active() will not fix
> > root cause of the problem, but rather hide it :( and, probably, real fix will be 
> > to update USB framework to ensure that all suspend devices are also PM runtime suspend
> > (not sure how) or add few more pm_suspend_ignore_children() calls 
> >  (for example as I've tried to do in [2], but this was unfinished).
> > 
> > I've found very simple steps to reproduce suspend failure on am335x-evm (should also
> > work on BBB) -  do below sequence with USB device plugged:
> > 
> >    echo platform > /sys/power/pm_test 
> >    echo 1 > /sys/power/pm_print_times 
> >    [ echo 0 > /sys/module/printk/parameters/console_suspend ]
> >    echo mem > /sys/power/state 
> > 
> > [   95.499685] calling  47400000.usb+ @ 733, parent: ocp
> > [   95.504818] am335x-usb-childs 47400000.usb: runtime PM trying to suspend device but active child
> > [   95.513750] am335x-usb-childs 47400000.usb: omap device suspend failure 0
> > 
> > Below I've attached possible patch which converts OMAP device to
> > use pm_runtime_force_suspend/resume().
> 
> It seems to almost work for my PM test cases.. It seems that serial console
> somehow won't get restored after suspend/resume cycle on omap3 though.
> 
> The system enters off mode during suspend, and wakes up properly so I can
> ssh to it after resume. But the serial console no longer works after resume.
> This is with 8250-omap driver.

And FYI, on omap4 this produces a bunch of L3 irq errors on suspend.

Tony
