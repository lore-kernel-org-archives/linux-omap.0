From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Fix inconsistency of completion in
	retu-rtc
Date: Wed, 15 Aug 2007 03:56:58 -0700
Message-ID: <20070815105657.GM19754@atomide.com>
References: <11871600384074-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11871600384074-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi.DOYU@nokia.com <Hiroshi.DOYU@nokia.com> [070814 23:52]:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> There was the case that multiple users can wait for completion.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/cbus/retu-rtc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
> index b36fd06..5d43520 100644
> --- a/drivers/cbus/retu-rtc.c
> +++ b/drivers/cbus/retu-rtc.c
> @@ -328,7 +328,7 @@ DECLARE_WORK(retu_rtca_work, retu_rtca_expired);
>  static void retu_rtcs_interrupt(unsigned long unused)
>  {
>  	retu_ack_irq(RETU_INT_RTCS);
> -	complete(&retu_rtc_sync);
> +	complete_all(&retu_rtc_sync);
>  }
>  
>  static void retu_rtca_interrupt(unsigned long unused)
> @@ -435,7 +435,7 @@ static struct platform_device retu_rtc_device = {
>  /* This function provides syncronization with the RTCS interrupt handler */
>  static void retu_rtc_barrier(void)
>  {
> -	init_completion(&retu_rtc_sync);
> +	INIT_COMPLETION(retu_rtc_sync);
>  	retu_ack_irq(RETU_INT_RTCS);
>  	retu_enable_irq(RETU_INT_RTCS);
>  	wait_for_completion(&retu_rtc_sync);
> -- 

Pushing today.

Tony
