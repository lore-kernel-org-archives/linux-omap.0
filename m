From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
Date: Mon, 25 Mar 2013 22:36:23 +0000
Message-ID: <201303252236.23270.arnd@arndb.de>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com> <20130325172633.GP30923@n2100.arm.linux.org.uk> <5150C16A.3040208@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5150C16A.3040208@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, John Stultz <john.stultz@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Monday 25 March 2013, Rob Herring wrote:
> I count integrator-cp, realview, versatile and non-DT VExpress that do
> this (not surprisingly) and 25 platforms or timer implementations plus
> arm64 that do sched_clock setup in time_init. What's broken by not
> moving these earlier?

timekeeping_init() will leave the persistent_clock_exist variable as "false",
which is read in rtc_suspend() and timekeeping_inject_sleeptime().

For all I can tell, you will get a little jitter every time you
do a suspend in that case. Or perhaps it means the system clock
will be forwarded by the amount of time spent in suspend twice
after wakeup, but I'm probably misreading the code for that case.

	Arnd
