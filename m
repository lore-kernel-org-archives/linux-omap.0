From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] change lpj in arm smp common code
Date: Wed, 29 Feb 2012 10:21:19 -0800
Message-ID: <87sjhtec0w.fsf@ti.com>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
	(Richard Zhao's message of "Wed, 29 Feb 2012 15:18:13 +0800")
Sender: cpufreq-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux@arm.linux.org.uk, davej@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com, davidb@codeaurora.org, arnd@arndb.de, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-omap@vger.kernel.org

Richard Zhao <richard.zhao@linaro.org> writes:

> The two patches were originally in [PATCH V6 0/7] add a generic cpufreq driver.
> I seperated them and hope they can go to upstream earlier.
>
> Richard Zhao (2):
>   ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
>   cpufreq: OMAP: remove loops_per_jiffy recalculate for smp

The first one should go into Russell's patch system.  Once he queues
that, I can queue the OMAP one for the CPUfreq maintainer.

Kevin
