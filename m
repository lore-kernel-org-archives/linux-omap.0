From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] CBUS: Fix retu-headset driver by not using removed
	input_dev->private field
Date: Tue, 6 May 2008 15:13:26 -0700
Message-ID: <20080506221326.GG18682@atomide.com>
References: <1210062788-15087-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61960 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933807AbYEFWN2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 18:13:28 -0400
Content-Disposition: inline
In-Reply-To: <1210062788-15087-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080506 01:33]:
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  drivers/cbus/retu-headset.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
> index f9de5cd..e798bc2 100644
> --- a/drivers/cbus/retu-headset.c
> +++ b/drivers/cbus/retu-headset.c
> @@ -232,7 +232,6 @@ static int __init retu_headset_probe(struct platform_device *pdev)
>  	}
>  	hs->idev->name = "retu-headset";
>  	hs->idev->dev.parent = &pdev->dev;
> -	hs->idev->private = hs;
>  	set_bit(EV_KEY, hs->idev->evbit);
>  	set_bit(RETU_HEADSET_KEY, hs->idev->keybit);
>  	r = input_register_device(hs->idev);

Pushing.

Tony
