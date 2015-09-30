From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH 00/11] arm: omap: counter32k rework
Date: Wed, 30 Sep 2015 10:22:46 +0200
Message-ID: <1986790.syN3WBv9AR@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 September 2015 15:43:55 Felipe Balbi wrote:
> 
> the following patches de-obfuscate arch/arm/mach-omap2/timer.c
> and start moving code to drivers/clocksource. So far only counter32k
> has been moved over.
> 
> Note that we can't get rid of all the code (yet) because there are
> still platforms relying to legacy boot and because of the strong
> coupling with OMAP's hwmod layer.
> 
> This is, for now, an RFC and has be written on top of [1]. Boot tested
> with AM335x and AM437x.
> 
> [1] http://marc.info/?l=linux-omap&m=144354336924308&w=2

Looks very nice!

> ps: if anybody has a good idea on how to get rid of
> register_persistent_clock(), please let me know

I don't think we want to get rid of that, because it is the more
accurate interface. IIRC systems that have an RTC will use
timekeeping_inject_sleeptime64() in rtc_resume(). I don't know however
how the two methods are coordinated, i.e. how the kernel ensures that
exactly one of the two is used, but never both.

	Arnd
