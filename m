From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/19] ARM: OMAP4 device off support
Date: Fri, 20 Apr 2012 15:58:40 +0300
Message-ID: <1334926721.2149.40.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	 <CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32885 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab2DTM6r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 08:58:47 -0400
In-Reply-To: <CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Fri, 2012-04-20 at 17:50 +0530, T Krishnamoorthy, Balaji wrote:
> On Fri, Apr 20, 2012 at 3:03 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > Hi,
> >
> > First version for this work. Applies on top of mainline + iochain set +
> > OMAP4 core retention set. Working tree available here:
> > tree: git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > branch: mainline-3.4-omap4-dev-off
> >
> > Tested on omap4430 EMU blaze + omap4460 GP panda boards.
> >
> > Some drivers have issues with device off, most notably MMC, as it breaks
> > device off on blaze device after 1 entry to device off mode:
> >
> > [  208.906921] omap_i2c omap_i2c.1: XRDY IRQ while no data to send
> > [  209.905639] omap_i2c omap_i2c.1: controller timed out
> > [  209.905792] twl: i2c_read failed to transfer all messages
> > [  209.905792] omap_hsmmc omap_hsmmc.1: could not set regulator OCR (-110)
> > [  212.296203] mmc0: error -110 during resume (card was removed?)
> Hi Tero,
> 
> I tried your branch on gp/emu devices but could not reproduce this issue.
> My observation is that while resuming, omap_hsmmc.1 eMMC is
> trying to turn on phoenix vaux1 regulator via i2c which fails due
> to controller timeout.
> Note: eMMC is present only on sdp/blaze

Did you try this with off-mode enabled and did you check the device
actually goes to off? (see pm_debug/count and verify core off count is
increasing.) And as said, I was only able to see this problem on a blaze
device, panda works fine. But yes, you are probably right and it is not
an MMC driver issue but I2C.

> 
> > [  212.562164] PM: resume of devices complete after 3656.007 msecs
> > [  212.660125] Restarting tasks ... done.
> > #
> > # echo mem > /sys/power/state
> > [  220.376892] PM: Syncing filesystems ... done.
> > [  220.382476] Freezing user space processes ... (elapsed 0.01 seconds) done.
> > [  220.408386] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) don
> > e.
> > [  220.439605] Suspending console(s) (use no_console_suspend to debug)
> > [  220.454650] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -110
> > [  220.454711] PM: Device omap_hsmmc.1 failed to suspend: error -110
> > [  220.454711] PM: Some devices failed to suspend
> > [  220.718261] PM: resume of devices complete after 263.539 msecs
> > [  220.743988] Restarting tasks ... done.
> >
> > Attempting to disable MMC from config prevented boot completely for me,
> > so this issue is likely to stay until someone fixes the MMC driver.
> > Panda device works fine though, although the wakeup from device off is
> > slow due to problems with some other drivers (most likely I2C.)
> >
> 
> can you try this patch if you want to disable MMC
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/74540

Tried this patch and disabled MMC completely. Device off now works with
blaze board also multiple times.

-Tero

> or
> http://www.spinics.net/lists/linux-omap/msg67879.html
> and build omap_hsmmc as module.
> 
> > Off mode is disabled by default, it can be enabled by either calling
> > omap4_pm_enable_off_mode(1) from board files or alternatively writing
> > to a debugfs node from userspace:
> >
> > echo 1 > /debug/pm_debug/enable_off_mode
> >
> > Device off entry can be tracked through the debugfs also, it increases
> > the core_pwrdm OFF state counter / timer, as this is an invalid state
> > for the chip normally (core enters OSWR in device off.) Not sure if this
> > a good way to do this but comments are welcome.
> >
> > -Tero
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


