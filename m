From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-rc6-omap] ASOC: quieter boot for non-Overo boards
Date: Thu, 25 Sep 2008 15:49:36 +0300
Message-ID: <20080925124934.GR5222@atomide.com>
References: <200809211414.42194.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52146 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYIYMtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 08:49:40 -0400
Content-Disposition: inline
In-Reply-To: <200809211414.42194.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

* David Brownell <david-b@pacbell.net> [080922 00:50]:
> Get rid of bogus ASOC boot messages on non-Overo boards.

I'm not touching this without an ack from alsa list :)

Tony

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  sound/soc/omap/overo.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- a/sound/soc/omap/overo.c
> +++ b/sound/soc/omap/overo.c
> @@ -107,11 +107,11 @@ static int __init overo_soc_init(void)
>  {
>  	int ret;
>  
> -	printk(KERN_INFO "overo SoC init\n");
>  	if (!machine_is_overo()) {
> -		printk(KERN_ERR "Not Overo!\n");
> +		pr_debug("Not Overo!\n");
>  		return -ENODEV;
>  	}
> +	printk(KERN_INFO "overo SoC init\n");
>  
>  	overo_snd_device = platform_device_alloc("soc-audio", -1);
>  	if (!overo_snd_device) {
> @@ -135,13 +135,12 @@ err1:
>  
>  	return ret;
>  }
> +module_init(overo_soc_init);
>  
>  static void __exit overo_soc_exit(void)
>  {
>  	platform_device_unregister(overo_snd_device);
>  }
> -
> -module_init(overo_soc_init);
>  module_exit(overo_soc_exit);
>  
>  MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
