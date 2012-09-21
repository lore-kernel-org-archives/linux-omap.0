From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: Beagleboard xM crashes when being set to 800MHz with smartreflex
 on linux-omap-3.6-rc6
Date: Fri, 21 Sep 2012 07:52:14 -0500
Message-ID: <CAOCHtYgfGqJzO2cs2_EP6HcZyxR7pU=JW0EwGJqFi4UBz5NBUw@mail.gmail.com>
References: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38772 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab2IUMwP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 08:52:15 -0400
Received: by vbbff1 with SMTP id ff1so3781841vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 05:52:14 -0700 (PDT)
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 21, 2012 at 1:45 AM, Maximilian Schwerin
<Maximilian.Schwerin@tigris.de> wrote:
> Hi,
>
> I've just built a linux-omap kernel at 3.6-rc6 using omap2plus_defconfig
> as basis for the kernel config.
>
> When I enable smartreflex and switch to 800MHz via
>
> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_core/autocomp
> echo 1 > /sys/kernel/debug/smartreflex/smartreflex_mpu_iva/autocomp
> cpufreq-set -f 800MHz
>
> the board crashes. If I switch to 800MHz and enable smartreflex later
> nothing happens. This used to work in my 3.3 based kernel.

btw, once it locks up... retry with your 3.3 based kernel (hold reset
and swap sd card's, the "bug" should lock up again when trying to set
800Mhz on bootup..  In my testing, once it locks up, any cpufreq
enabled kernel will keep locking up...  Makes you wonder if a pll
setting isn't getting reset on bootup...)

I've traced it to the "arch_clock->clk_set_rate(clk, rate);" call in
the "int clk_set_rate(struct clk *clk, unsigned long rate)" function

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/plat-omap/clock.c;hb=HEAD#l132

at that point, I'm a little lost in the omap36xx code..

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
