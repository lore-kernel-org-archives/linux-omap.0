From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/2] ARM: omap: hwmod: Restore sysc after a reset
Date: Thu, 05 Apr 2012 12:41:26 +0530
Message-ID: <4F7D459E.3090902@ti.com>
References: <1331646928-31119-1-git-send-email-rnayak@ti.com> <1331646928-31119-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204040939300.8000@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:59116 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752167Ab2DEHLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 03:11:35 -0400
Received: by obbwc18 with SMTP id wc18so2352884obb.27
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 00:11:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204040939300.8000@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

On Wednesday 04 April 2012 09:11 PM, Paul Walmsley wrote:
> On Tue, 13 Mar 2012, Rajendra Nayak wrote:
>
>> After a softreset, make sure the sysc settings are correctly
>> restored.
>>
>> Reported-by: Anand Gadiyar<gadiyar@ti.com>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Shubhrajyoti D<shubhrajyoti@ti.com>
>
> Thanks, this patch has been modified a bit to consolidate the SYSCONFIG
> reload after _reset() into the _reset() function itself.  This should
> hopefully avoid future mistakes and avoid some code duplication.  Modified
> patch follows, queued for 3.4-rc.

Thanks, changes look good.

>
>
> - Paul
>
>
> From: Rajendra Nayak<rnayak@ti.com>
> Date: Tue, 13 Mar 2012 22:55:23 +0530
> Subject: [PATCH] ARM: OMAP2+: hwmod: Restore sysc after a reset
>
> After a softreset, make sure the sysc settings are correctly
> restored.
>
> Reported-by: Anand Gadiyar<gadiyar@ti.com>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Shubhrajyoti D<shubhrajyoti@ti.com>
> [paul@pwsan.com: combined post-reset SYSCONFIG reload code into the
>   _reset() function to avoid duplication and future mistakes]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5a68010..d32c1ce 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1477,6 +1477,11 @@ static int _reset(struct omap_hwmod *oh)
>
>   	ret = (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh);
>
> +	if (oh->class->sysc) {
> +		_update_sysc_cache(oh);
> +		_enable_sysc(oh);
> +	}
> +
>   	return ret;
>   }
>
> @@ -1786,20 +1791,9 @@ static int _setup(struct omap_hwmod *oh, void *data)
>   		return 0;
>   	}
>
> -	if (!(oh->flags&  HWMOD_INIT_NO_RESET)) {
> +	if (!(oh->flags&  HWMOD_INIT_NO_RESET))
>   		_reset(oh);
>
> -		/*
> -		 * OCP_SYSCONFIG bits need to be reprogrammed after a softreset.
> -		 * The _enable() function should be split to
> -		 * avoid the rewrite of the OCP_SYSCONFIG register.
> -		 */
> -		if (oh->class->sysc) {
> -			_update_sysc_cache(oh);
> -			_enable_sysc(oh);
> -		}
> -	}
> -
>   	postsetup_state = oh->_postsetup_state;
>   	if (postsetup_state == _HWMOD_STATE_UNKNOWN)
>   		postsetup_state = _HWMOD_STATE_ENABLED;

