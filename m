From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM / OPP: Fix build when CONFIG_PM_OPP is not set
Date: Thu, 3 Nov 2011 01:21:42 +0100
Message-ID: <201111030121.42432.rjw@sisk.pl>
References: <20111102170055.GI31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111102170055.GI31337@atomide.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, November 02, 2011, Tony Lindgren wrote:
> Commit 03ca370fbf7b76d6d002380dbdc2cdc2319f9c80 (PM / OPP: Add
> OPP availability change notifier) does not compile if CONFIG_PM_OPP
> is not set:
> 
> arch/arm/plat-omap/omap-pm-noop.o: In function `opp_get_notifier':
> include/linux/opp.h:103: multiple definition of `opp_get_notifier'
> include/linux/opp.h:103: first defined here
> 
> Also fix incorrect comment.
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied to linux-pm/linux-next.

Thanks,
Rafael


> ---
> 
> I'm seeing this with omap1_defconfig at least.
> 
> --- a/include/linux/opp.h
> +++ b/include/linux/opp.h
> @@ -97,11 +97,11 @@ static inline int opp_disable(struct device *dev, unsigned long freq)
>  	return 0;
>  }
>  
> -struct srcu_notifier_head *opp_get_notifier(struct device *dev)
> +static inline struct srcu_notifier_head *opp_get_notifier(struct device *dev)
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> -#endif		/* CONFIG_PM */
> +#endif		/* CONFIG_PM_OPP */
>  
>  #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
>  int opp_init_cpufreq_table(struct device *dev,
> 
> 
