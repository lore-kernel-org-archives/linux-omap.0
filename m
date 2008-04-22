From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Refrain compile warning for lm8323.c
Date: Tue, 22 Apr 2008 12:24:20 -0700
Message-ID: <20080422192420.GI24257@atomide.com>
References: <1208870513-13351-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57160 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765088AbYDVTYW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 15:24:22 -0400
Content-Disposition: inline
In-Reply-To: <1208870513-13351-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080422 06:26]:
> drivers/input/keyboard/lm8323.c: In function 'lm8323_pwm_store_time':
> drivers/input/keyboard/lm8323.c:590: warning: passing argument 3 of 'strict_strtoul' from incompatible pointer type
> drivers/input/keyboard/lm8323.c: In function 'lm8323_set_disable':
> drivers/input/keyboard/lm8323.c:664: warning: passing argument 3 of 'strict_strtoul' from incompatible pointer type
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/input/keyboard/lm8323.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index 3040622..c9ede10 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -587,7 +587,7 @@ static ssize_t lm8323_pwm_store_time(struct device *dev,
>  	int ret;
>  	int time;
>  
> -	ret = strict_strtoul(buf, 10, &time);
> +	ret = sscanf(buf, "%d", &time);
>  	/* Numbers only, please. */
>  	if (ret)
>  		return -EINVAL;
> @@ -661,7 +661,7 @@ static ssize_t lm8323_set_disable(struct device *dev,
>  	int ret;
>  	int i;
>  
> -	i = strict_strtoul(buf, 10, &ret);
> +	i = sscanf(buf, "%d", &ret);
>  
>  	mutex_lock(&lm->lock);
>  	lm->kp_enabled = !i;

Pushing.

Tony
