From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add return value check for
	input_register_device()
Date: Tue, 22 Apr 2008 12:24:05 -0700
Message-ID: <20080422192403.GH24257@atomide.com>
References: <1208870502-13321-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50502 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763645AbYDVTYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 15:24:07 -0400
Content-Disposition: inline
In-Reply-To: <1208870502-13321-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080422 06:26]:
> drivers/cbus/retu-pwrbutton.c:100: warning: ignoring return value of 'input_register_device', declared with attribute warn_unused_result
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/cbus/retu-pwrbutton.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
> index 283d9ca..38d7aa4 100644
> --- a/drivers/cbus/retu-pwrbutton.c
> +++ b/drivers/cbus/retu-pwrbutton.c
> @@ -97,9 +97,7 @@ static int __init retubutton_init(void)
>  	pwrbtn_dev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
>  	pwrbtn_dev->name = "retu-pwrbutton";
>  
> -	input_register_device(pwrbtn_dev);
> -
> -	return 0;
> +	return input_register_device(pwrbtn_dev);
>  }
>  
>  /**

Pushing.

Tony
