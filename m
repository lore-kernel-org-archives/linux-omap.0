From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/10] cpufreq: OMAP: Add SMP support for OMAP4+
Date: Thu, 29 Aug 2013 15:32:55 +0530
Message-ID: <CAOh2x=k11EivJoy5-PMXnE5JGDc=DcJKhae7qoh6tNc4L63VnA@mail.gmail.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
	<1316725648-26710-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1316725648-26710-3-git-send-email-khilman@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Dave Jones <davej@redhat.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 23, 2011 at 2:37 AM, Kevin Hilman <khilman@ti.com> wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
>
> On OMAP SMP configuartion, both processors share the voltage
> and clock. So both CPUs needs to be scaled together and hence
> needs software co-ordination.
>
> Also, update lpj with reference value to avoid progressive error.
>
> Adjust _both_ the per-cpu loops_per_jiffy and global lpj. Calibrate
> them with with reference to the initial values to avoid a
> progressively bigger and bigger error in the value over time.
>
> While at this, re-use the notifiers for UP/SMP since on UP machine or
> UP_ON_SMP policy->cpus mask would contain only the boot CPU.
>
> Based on initial SMP support by Santosh Shilimkar.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [khilman@ti.com: due to overlap/rework, combined original Santosh patch
>                  and Russell's rework]
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  drivers/cpufreq/omap-cpufreq.c |   80 +++++++++++++++++++++++++++++++++++-----
>  1 files changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c

> +       /*
> +        * On OMAP SMP configuartion, both processors share the voltage
> +        * and clock. So both CPUs needs to be scaled together and hence
> +        * needs software co-ordination. Use cpufreq affected_cpus
> +        * interface to handle this scenario. Additional is_smp() check
> +        * is to keep SMP_ON_UP build working.
> +        */
> +       if (is_smp()) {
> +               policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +               cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
> +               cpumask_copy(policy->cpus, cpumask);
> +       }

Does somebody remember importance of is_smp() here??

Current code looks like:

if (is_smp())
    cpumask_setall(policy->cpus);

And I was looking to remove this check if it is no more useful.. And
so simply do

cpumask_setall(policy->cpus);
