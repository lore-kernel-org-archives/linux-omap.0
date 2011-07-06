From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] arm: platsmp: Allow secondary cpu hotplug with
	maxcpus=1
Date: Wed, 6 Jul 2011 23:55:50 +0100
Message-ID: <20110706225550.GA28957@n2100.arm.linux.org.uk>
References: <1309886957-7548-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1309886957-7548-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Kukjin Kim <kgene.kim@samsung.com>, David Brown <davidb@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 05, 2011 at 10:29:17AM -0700, Stephen Boyd wrote:
> If an ARM system has multiple cpus in the same socket and the
> kernel is booted with maxcpus=1, secondary cpus are possible but
> not present due to how platform_smp_prepare_cpus() is called.
> Since most typical ARM processors don't actually support physical
> hotplug, initialize the present map to be equal to the possible
> map in generic ARM SMP code. Also, always call
> platform_smp_prepare_cpus() as long as max_cpus is non-zero (0
> means no SMP) to allow platform code to do any SMP setup.
> 
> After applying this patch it's possible to boot an ARM system
> with maxcpus=1 on the command line and then hotplug in secondary
> cpus via sysfs. This is more in line with how x86 does things.

Ok - how about putting this in the patch system?

Thanks.
