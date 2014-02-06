From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
Date: Thu, 6 Feb 2014 13:26:51 +0200
Message-ID: <52F3717B.6020809@ti.com>
References: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Illia Smyrnov <illia.smyrnov@globallogic.com>, =?ISO-8859-1?Q?Beno=EE?= =?ISO-8859-1?Q?t_Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Illia,

On 02/05/2014 05:06 PM, Illia Smyrnov wrote:
> Commit 313a76e (ARM: OMAP2+: hwmod: Fix SOFTRESET logic) introduced
> softreset bit cleaning right after set one. It is caused L3 error for
> OMAP4 ISS because ISS register write occurs when ISS reset process is in
> progress. Avoid this situation by cleaning softreset bit later, when reset
> process is successfully finished.
> 
> Signed-off-by: Illia Smyrnov <illia.smyrnov@globallogic.com>

Thanks for the patch. Could you please send --cc this to stable as well. Thanks.

cheers,
-roger

> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 42d8188..1f33f5d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1947,29 +1947,31 @@ static int _ocp_softreset(struct omap_hwmod *oh)
>  		goto dis_opt_clks;
>  
>  	_write_sysconfig(v, oh);
> -	ret = _clear_softreset(oh, &v);
> -	if (ret)
> -		goto dis_opt_clks;
> -
> -	_write_sysconfig(v, oh);
>  
>  	if (oh->class->sysc->srst_udelay)
>  		udelay(oh->class->sysc->srst_udelay);
>  
>  	c = _wait_softreset_complete(oh);
> -	if (c == MAX_MODULE_SOFTRESET_WAIT)
> +	if (c == MAX_MODULE_SOFTRESET_WAIT) {
>  		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
>  			   oh->name, MAX_MODULE_SOFTRESET_WAIT);
> -	else
> +		ret = -ETIMEDOUT;
> +		goto dis_opt_clks;
> +	} else {
>  		pr_debug("omap_hwmod: %s: softreset in %d usec\n", oh->name, c);
> +	}
> +
> +	ret = _clear_softreset(oh, &v);
> +	if (ret)
> +		goto dis_opt_clks;
> +
> +	_write_sysconfig(v, oh);
>  
>  	/*
>  	 * XXX add _HWMOD_STATE_WEDGED for modules that don't come back from
>  	 * _wait_target_ready() or _reset()
>  	 */
>  
> -	ret = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
> -
>  dis_opt_clks:
>  	if (oh->flags & HWMOD_CONTROL_OPT_CLKS_IN_RESET)
>  		_disable_optional_clocks(oh);
> 
