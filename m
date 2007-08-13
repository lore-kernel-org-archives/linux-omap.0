From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix warning in arch/arm/mach-omap2/timer-gp.c
Date: Mon, 13 Aug 2007 01:58:20 -0700
Message-ID: <20070813085820.GI13948@atomide.com>
References: <007201c7dd55$68d24d80$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <007201c7dd55$68d24d80$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kmpark@infradead.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kyungmin.park@samsung.com> [070812 19:55]:
> Fix warning in arch/arm/mach-omap2/timer-gp.c
> arch/arm/mach-omap2/timer-gp.c: In function `omap2_gp_timer_set_mode':
> arch/arm/mach-omap2/timer-gp.c:89: warning: enumeration value
> `CLOCK_EVT_MODE_RESUME' not handled in switch
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
> index 8f380a1..2246435 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -84,6 +84,7 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode
> mode,
>  		break;
>  	case CLOCK_EVT_MODE_UNUSED:
>  	case CLOCK_EVT_MODE_SHUTDOWN:
> +	case CLOCK_EVT_MODE_RESUME:
>  		break;
>  	}
>  }

Pushing today.

Tony
