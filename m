From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 6/6] ARM: OMAP: fix cpufreq build
Date: Thu, 15 Mar 2012 10:10:19 -0700
Message-ID: <87aa3hdc3o.fsf@ti.com>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
	<E1S87xU-0000N8-6u@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <E1S87xU-0000N8-6u@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Thu, 15 Mar 2012 10:31:00 +0000")
Sender: cpufreq-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Dave Jones <davej@redhat.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> OMAPs cpufreq requires the frequency table support, but nothing ensures
> that this is selected.  This can result in configurations which fail to
> build:
>
> drivers/built-in.o:(.data+0x5238): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
> drivers/cpufreq/omap-cpufreq.c:88: undefined reference to `cpufreq_frequency_table_target'
> drivers/cpufreq/omap-cpufreq.c:60: undefined reference to `cpufreq_frequency_table_verify'
> drivers/cpufreq/omap-cpufreq.c:186: undefined reference to `cpufreq_frequency_table_cpuinfo'
> drivers/cpufreq/omap-cpufreq.c:190: undefined reference to `cpufreq_frequency_table_get_attr'
>
> Fix this by introducing a new configuration variable and having that
> select CPU_FREQ_TABLE.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
>  arch/arm/mach-omap2/clock.c                  |    2 +-
>  arch/arm/mach-omap2/clock.h                  |    2 +-
>  arch/arm/plat-omap/clock.c                   |    2 +-
>  arch/arm/plat-omap/include/plat/clock.h      |    4 ++--

The arch/arm/* stuff is all code that has been removed, but the pull
request didn't make it in time for v3.4:

   http://www.spinics.net/lists/arm-kernel/msg164545.html

Initially, this was intended as a cleanup because it was just dead code
removal, but since we missed v3.4, maybe we should pull out 
"ARM: OMAP: clock: cleanup CPUfreq leftovers" and submit for 3.4-rc.

>  drivers/cpufreq/Kconfig.arm                  |    5 +++++
>  drivers/cpufreq/Makefile                     |    2 +-

This change was included in my CPUfreq pull request to Dave Jones.  He
has pulled it into his fixes branch[1], but I don't see it upstream.
I've just sent a mail to Dave asking about it.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/davej/cpufreq.git fixes

