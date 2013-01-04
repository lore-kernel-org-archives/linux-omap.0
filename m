From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 07/12] ARM: OMAP2+: PM: use power domain functional
 state in stats counters
Date: Fri, 4 Jan 2013 16:07:17 +0200
Message-ID: <1357308437.2221.106.camel@sokoban>
References: <20121209174545.6933.59371.stgit@dusk.lan>
	 <20121209175314.6933.92188.stgit@dusk.lan>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55940 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613Ab3ADOHX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 09:07:23 -0500
In-Reply-To: <20121209175314.6933.92188.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Paul,

On Sun, 2012-12-09 at 10:53 -0700, Paul Walmsley wrote:
> From: Jean Pihet <jean.pihet@newoldbits.com>
> 
> The PM code uses some counters to keep track of the power domains
> transitions, in order to provide the information to drivers (in
> pwrdm_get_context_loss_count) and to expose the information to
> sysfs for debug purpose.
> 
> This patch provides the information for each functional state.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> [paul@pwsan.com: use PWRDM_FPWRSTS_COUNT due to functional power state offset;
>  use powerdomain.c fn to convert func pwrsts to names; rename 'state' to
>  'fpwrst' to indicate use of func pwrsts; convert remaining users of the
>  non-func pwrst API; add some kerneldoc]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c    |   42 ++++-----
>  arch/arm/mach-omap2/powerdomain.c |  167 ++++++++++++++++++-------------------
>  arch/arm/mach-omap2/powerdomain.h |   17 ++--
>  3 files changed, 108 insertions(+), 118 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 806a06b..72cf9e0 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -53,13 +53,6 @@ enum {
>  	DEBUG_FILE_TIMERS,
>  };
>  
> -static const char pwrdm_state_names[][PWRDM_MAX_PWRSTS] = {
> -	"OFF",
> -	"RET",
> -	"INA",
> -	"ON"
> -};
> -
>  void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
>  {
>  	s64 t;
> @@ -70,7 +63,7 @@ void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
>  	/* Update timer for previous state */
>  	t = sched_clock();
>  
> -	pwrdm->state_timer[prev] += t - pwrdm->timer;
> +	pwrdm->fpwrst_timer[prev - PWRDM_FPWRST_OFFSET] += t - pwrdm->timer;
>  
>  	pwrdm->timer = t;
>  }
> @@ -79,6 +72,7 @@ static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
>  {
>  	struct seq_file *s = (struct seq_file *)user;
>  
> +	/* XXX This needs to be implemented in a better way */

IMO, this part should be dropped, or re-implemented completely. It is
uninformative and I don't think anybody uses it. With the usecounting
fixes in place, it is better than before but still doesn't provide too
much useful information. Would be good to show the clocks that actually
are enabled along with the clockdomain use counts, but in either case,
it doesn't belong in the same debugfs file as the pwrdm counters.

-Tero



