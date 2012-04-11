From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Tue, 10 Apr 2012 18:11:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204101803020.20894@utopia.booyaka.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com> <1331659524-7635-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58714 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab2DKALh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:11:37 -0400
In-Reply-To: <1331659524-7635-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Hi Rajendra,

On Tue, 13 Mar 2012, Rajendra Nayak wrote:

> omap_hwmod_softreset() does not seem to wait for reset status
> after doing a softreset. Make it use _ocp_softreset() instead
> which does this correctly.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

Just noticed that this change results in I2C softreset failed messages on 
OMAP2/3/4 on v3.4-rc2.  For example, on 2420:

[    0.200378] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.222076] omap_hwmod: i2c2: softreset failed (waited 10000 usec)

Looking more closely at the code, I think the intention of the original 
code was basically correct.  HDQ and I2C both need to execute some custom 
reset code after the SOFTRESET bit is set, but before the RESETDONE bit is 
tested.  After this patch, the internal hwmod code tries to wait for 
RESETDONE to change, before the custom code runs -- and that is going to 
fail.

Just out of curiosity, was the change in this patch prompted by some code 
that needed the change?  Or was this a theoretical problem, driven by a 
code review?  If the latter, we should probably revert this patch, and 
maybe improve the documentation and omap_hwmod_softreset() function name 
to clarify what it actually does.  But if it's the former, it looks like 
we'll need a way to support both the full, standard SOFTRESET sequence 
(perhaps via omap_hwmod_reset() ?) while also supporting the HDQ/I2C 
custom reset code.


regards,


- Paul


> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 6c0e7eb..0c64853 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2423,20 +2423,10 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
>   */
>  int omap_hwmod_softreset(struct omap_hwmod *oh)
>  {
> -	u32 v;
> -	int ret;
> -
> -	if (!oh || !(oh->_sysc_cache))
> +	if (!oh)
>  		return -EINVAL;
>  
> -	v = oh->_sysc_cache;
> -	ret = _set_softreset(oh, &v);
> -	if (ret)
> -		goto error;
> -	_write_sysconfig(v, oh);
> -
> -error:
> -	return ret;
> +	return _ocp_softreset(oh);
>  }
>  
>  /**
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
