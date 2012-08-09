From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 1/2] cpufreq: OMAP: Handle missing frequency table on SMP systems
Date: Thu, 9 Aug 2012 11:32:14 +0200
Message-ID: <201208091132.14992.rjw@sisk.pl>
References: <1344496102-24451-1-git-send-email-rnayak@ti.com> <1344496102-24451-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50263 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998Ab2HIJ0U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 05:26:20 -0400
In-Reply-To: <1344496102-24451-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-pm@vger.kernel.org

On Thursday, August 09, 2012, Rajendra Nayak wrote:
> On OMAP4, if the first CPU fails to get a valid frequency table (this
> could happen if the platform does not register any OPP table), the
> subsequent CPU instances end up dealing with a NULL freq_table and
> crash.
> 
> Check for an already existing freq_table, before trying to create one,
> and increment the freq_table_users only if the table is sucessfully
> created.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: <linux-pm@vger.kernel.org>

Kevin, are you going to merge this?

Rafael


> ---
>  drivers/cpufreq/omap-cpufreq.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 17fa04d..b47034e 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -218,7 +218,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
>  
> -	if (atomic_inc_return(&freq_table_users) == 1)
> +	if (!freq_table)
>  		result = opp_init_cpufreq_table(mpu_dev, &freq_table);
>  
>  	if (result) {
> @@ -227,6 +227,8 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  		goto fail_ck;
>  	}
>  
> +	atomic_inc_return(&freq_table_users);
> +
>  	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
>  	if (result)
>  		goto fail_table;
> 

