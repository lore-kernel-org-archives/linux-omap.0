From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] usb: musb: fix the possible panic while resuming
Date: Thu, 26 Feb 2009 02:13:59 +0200
Message-ID: <20090226001358.GK4639@gandalf>
References: <4d34a0a70902250353i3c6e072bnd41af327bc77601b@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60775 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbZBZAOF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 19:14:05 -0500
Content-Disposition: inline
In-Reply-To: <4d34a0a70902250353i3c6e072bnd41af327bc77601b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: linux-usb@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, q1.kim@samsung.com, Minkyu Kang <mk7.kang@samsung.com>

On Wed, Feb 25, 2009 at 08:53:00PM +0900, Kim Kyuwon wrote:
> From: Kim Kyuwon <chammoru@gmail.com>
> 
> While waking up, musb can cause a kernel panic. This patch is fixing
> it by enabling the clock in the resume_early method.
> 
> Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
> ---
>  drivers/usb/musb/musb_core.c |   21 +++++++--------------
>  1 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 2cc34fa..ae76ad7 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2141,16 +2141,13 @@ static int __devexit musb_remove(struct
> platform_device *pdev)
> 
>  #ifdef	CONFIG_PM
> 
> -static int musb_suspend(struct platform_device *pdev, pm_message_t message)
> +static int musb_suspend_late(struct platform_device *pdev, pm_message_t state)
>  {
> -	unsigned long	flags;
> -	struct musb	*musb = dev_to_musb(&pdev->dev);
> +	struct musb *musb = dev_to_musb(&pdev->dev);

this hunk is unecessary, please revert. I'll also take a closer look
tomorrow, it's already really late and need some nap (as suggested by
greg, hehe :-p)

-- 
balbi
