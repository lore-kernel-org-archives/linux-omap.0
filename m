From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
Date: Tue, 13 Mar 2012 19:29:09 +0530
Message-ID: <4F5F52AD.6090009@ti.com>
References: <1331646928-31119-1-git-send-email-rnayak@ti.com> <1331646928-31119-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57780 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753592Ab2CMN7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 09:59:19 -0400
Received: by ghbg2 with SMTP id g2so638973ghb.29
        for <linux-omap@vger.kernel.org>; Tue, 13 Mar 2012 06:59:16 -0700 (PDT)
In-Reply-To: <1331646928-31119-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

On Tuesday 13 March 2012 07:25 PM, Rajendra Nayak wrote:
> omap_hwmod_softreset() does not seem to wait for reset status
> after doing a softreset. Make it use _ocp_softreset() instead
> which does this correctly.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Anand Gadiyar<gadiyar@ti.com>
> Cc: Shubhrajyoti D<shubhrajyoti@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   14 +++-----------
>   1 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index ae56939..9b49440 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1907,20 +1907,12 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
>    */
>   int omap_hwmod_softreset(struct omap_hwmod *oh)
>   {
> -	u32 v;
> -	int ret;
> -
> -	if (!oh || !(oh->_sysc_cache))
> +	if (!oh)
>   		return -EINVAL;
>
> -	v = oh->_sysc_cache;
> -	ret = _set_softreset(oh,&v);
> -	if (ret)
> -		goto error;
> -	_write_sysconfig(v, oh);
> +	_ocp_softreset(oh);
>
> -error:
> -	return ret;
> +	return 0;

Just realized, this should be 'return _ocp_softreset(oh);'
instead. will fix and repost.

>   }
>
>   /**

