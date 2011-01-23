From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCKtospeed-up boot
Date: Sun, 23 Jan 2011 12:55:25 +0530
Message-ID: <8d59200413b98810a4e7c2039ffb9a77@mail.gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
 <4D385155.4050301@gmail.com> <43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
 <4D38641E.2000301@gmail.com> <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
 <4D399F74.9050302@gmail.com> <20110121171555.GB30823@n2100.arm.linux.org.uk>
 <bccc6a7edf66bedd311bc869bfa89ae8@mail.gmail.com> <20110122212017.GA17725@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38429 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064Ab1AWHZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Jan 2011 02:25:29 -0500
Received: by fxm5 with SMTP id 5so3151039fxm.39
        for <linux-omap@vger.kernel.org>; Sat, 22 Jan 2011 23:25:27 -0800 (PST)
In-Reply-To: <20110122212017.GA17725@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rob Herring <robherring2@gmail.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Sunday, January 23, 2011 2:50 AM
> To: Santosh Shilimkar
> Cc: Rob Herring; linux-omap@vger.kernel.org; Linus Walleij; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] ARM: smp: Introduce
> ARCH_HAS_COMMON_CORES_CLOCKtospeed-up boot
>
> On Sat, Jan 22, 2011 at 01:14:21PM +0530, Santosh Shilimkar wrote:
> > Surely whichever way we should remove the recalibration otherwise
> > every time secondary cpus spend ~ 200 ms there.
> >
> > Russell,
> > How do you like to address this?
>
> Well, the last piece of the puzzle which needs consideration is that
> omitting the calibration means that it produces user-visible
> /proc/cpuinfo changes.  I can't say what effect that has.  So, I
> think we need to do something about that to ensure that userspace
> won't be impacted should they be using the information in there.
>
Ok. /proc/cpuinfo uses the per-cpu lpj which gets updated as mentioned
as part of the arch cpufreq drivers. So this not seems to be the
problem.

> Maybe we need to initialize the secondary CPU bogomips values
> accordingly?  Maybe zero is acceptable to mark that the calculation
> hasn't been done?  Dunno.
The only issue is global lpj not getting updated as part of CPU
scaling. This is anyway broken today on SMP machines even without
cpufreq. It's getting corrected as part of the hotplug path if
recalibration is carried out. And same value gets copied to
per-cpu lpj for the secondary cores.

The above gets completely wrong if the individual CPUs can
scale with different speed.

Since per-cpu lpj is suppose to be taken care by scaling
Code, /proc/cpuinfo will get updated with right information.

With this, I think we could safely skip secondary cpu
calibration.

Regards,
Santosh
