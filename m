From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]  Tiny fix. No comma after KERN_INFO.
Date: Wed, 2 Apr 2008 10:22:14 +0300
Message-ID: <20080402072213.GG31913@atomide.com>
References: <1207050850-926-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56503 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYDBHWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2008 03:22:16 -0400
Content-Disposition: inline
In-Reply-To: <1207050850-926-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org

* Roman Tereshonkov <roman.tereshonkov@nokia.com> [080401 14:54]:
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> ---
>  drivers/misc/sti/sdti.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
> index 9b20ccd..adfbcbc 100644
> --- a/drivers/misc/sti/sdti.c
> +++ b/drivers/misc/sti/sdti.c
> @@ -120,7 +120,7 @@ static int __init omap_sdti_init(void)
>  	i = sti_readl(SDTI_REVISION);
>  	snprintf(buf, sizeof(buf), "OMAP SDTI support loaded (HW v%u.%u)\n",
>  		(i >> 4) & 0x0f, i & 0x0f);
> -	printk(KERN_INFO, "%s", buf);
> +	printk(KERN_INFO "%s", buf);
>  	omap_sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
>  
>  	return 0;

Pushing today.

Tony
