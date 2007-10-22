From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix OMAP1 clockevent support for hrtimers
Date: Sun, 21 Oct 2007 17:10:48 -0700
Message-ID: <20071022001048.GE6984@atomide.com>
References: <20071018230443.276921918@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071018230443.276921918@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071018 16:05]:
> One-shot mode was broken in MPU-timer support for OMAP1 due to a typo.
> 
> Also, ensure timer is stopped before changing the auto-reload flag.
> The TRM says changing the AR flag when timer is running is undefined.
> 
> Signed-off-by: Tim Bird <tim.bird@am.sony.com>
> Signed-off-by: Kevin Hilman <khilman@mvista.com.
> 
> ---
>  arch/arm/mach-omap1/time.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Index: dev/arch/arm/mach-omap1/time.c
> ===================================================================
> --- dev.orig/arch/arm/mach-omap1/time.c
> +++ dev/arch/arm/mach-omap1/time.c
> @@ -132,13 +132,20 @@ static inline void omap_mpu_timer_start(
>  	timer->cntl = timerflags;
>  }
>  
> +static inline void omap_mpu_timer_stop(int nr)
> +{
> +	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
> +
> +	timer->cntl &= ~MPU_TIMER_ST;
> +}
> +
>  /*
>   * ---------------------------------------------------------------------------
>   * MPU timer 1 ... count down to zero, interrupt, reload
>   * ---------------------------------------------------------------------------
>   */
>  static int omap_mpu_set_next_event(unsigned long cycles,
> -				    struct clock_event_device *evt)
> +				   struct clock_event_device *evt)
>  {
>  	omap_mpu_timer_start(0, cycles, 0);
>  	return 0;
> @@ -152,6 +159,7 @@ static void omap_mpu_set_mode(enum clock
>  		omap_mpu_set_autoreset(0);
>  		break;
>  	case CLOCK_EVT_MODE_ONESHOT:
> +		omap_mpu_timer_stop(0);
>  		omap_mpu_remove_autoreset(0);
>  		break;
>  	case CLOCK_EVT_MODE_UNUSED:
> @@ -163,7 +171,7 @@ static void omap_mpu_set_mode(enum clock
>  
>  static struct clock_event_device clockevent_mpu_timer1 = {
>  	.name		= "mpu_timer1",
> -	.features       = CLOCK_EVT_FEAT_PERIODIC, CLOCK_EVT_FEAT_ONESHOT,
> +	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>  	.shift		= 32,
>  	.set_next_event	= omap_mpu_set_next_event,
>  	.set_mode	= omap_mpu_set_mode,

Pushing today.

Tony
