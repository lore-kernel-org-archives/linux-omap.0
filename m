From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard ES
Date: Fri, 10 Feb 2012 08:56:31 +0800
Message-ID: <CACVXFVPZjPVDfiD8hGty0O9j1DV9RbBd=wOyP5sivN5rD-0=5Q@mail.gmail.com>
References: <4F31A91B.8080106@umich.edu>
	<4F32063F.1020607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33915 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729Ab2BJA4c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 19:56:32 -0500
Received: by pbcun15 with SMTP id un15so2015771pbc.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 16:56:32 -0800 (PST)
In-Reply-To: <4F32063F.1020607@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Antipov <dmitry.antipov@linaro.org>
Cc: Andrew Richardson <chardson@umich.edu>, John Stultz <john.stultz@linaro.org>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org

Hi,

On Wed, Feb 8, 2012 at 1:21 PM, Dmitry Antipov
<dmitry.antipov@linaro.org> wrote:
> On 02/07/2012 02:43 PM, Andrew Richardson wrote:
>
>> I'm experiencing what appears to be a minimum clock resolution issue
>> in using clock_gettime() on a PandaBoard ES running ubuntu.
>
>
> Do you have CONFIG_OMAP_32K_TIMER enabled in your kernel?
> Look at 'dmesg | grep clock' and check for the following:
>
> ...
> OMAP clockevent source: GPTIMER1 at 32768 Hz
> sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
> ...
>
> Most probably this is the answer - by default, recent OMAPs are configured
> to use less-accurate, but more energy-saving timer (32KHz) in favor of
> MPU timer.

Sorry, I have a question about the two kind of timers. No matter
CONFIG_OMAP_32K_TIMER is defined or not, 'twd' interrupt count
is always increased in '/proc/interrupts', and 'gp timer' interrupt count
keeps unchanged, so looks MPU timer is still enabled even
CONFIG_OMAP_32K_TIMER is disabled, isn't it?

After some investigation, I found the change[1] can remove local
timer of 'twd', and tick will be driven by 'gp timer' interrupt, but I am
not sure if it is the right thing to do.

>
> Disable CONFIG_OMAP_32K_TIMER to switch to MPU timer, and check
> 'dmesg | grep clock' to see:
>
> ...
> OMAP clockevent source: GPTIMER1 at 38400000 Hz
> OMAP clocksource: GPTIMER2 at 38400000 Hz
> sched_clock: 32 bits at 38MHz, resolution 26ns, wraps every 111848ms
> ...
>
> BTW, I have no ideas why clock_getres(CLOCK_REALTIME,...) returns {0, 1}
> regardless of underlying clock source. I expect {0, 30517} for 32K timer
> and {0, 26} for MPU timer.
>

[1], 'not select LOCAL_TIMERS for OMAP4 SMP'
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d965da4..0036218 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -46,7 +46,7 @@ config ARCH_OMAP4
        select CPU_V7
        select ARM_GIC
        select HAVE_SMP
-       select LOCAL_TIMERS if SMP
+       #select LOCAL_TIMERS if SMP
        select PL310_ERRATA_588369
        select PL310_ERRATA_727915
        select ARM_ERRATA_720789


thanks,
-- 
Ming Lei
