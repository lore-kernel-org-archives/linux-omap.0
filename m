From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM][PATCH 4/4] OMAP3: Serial: kill dev_attr_sleep_timeout sparse warn
Date: Wed, 05 May 2010 16:57:40 -0700
Message-ID: <8739y5yk97.fsf@deeprootsystems.com>
References: <1270749249-14041-1-git-send-email-nm@ti.com>
	<1270749249-14041-2-git-send-email-nm@ti.com>
	<1270749249-14041-3-git-send-email-nm@ti.com>
	<1270749249-14041-4-git-send-email-nm@ti.com>
	<1270749249-14041-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f189.google.com ([209.85.221.189]:45128 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab0EEX5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 19:57:46 -0400
Received: by qyk27 with SMTP id 27so11208069qyk.23
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 16:57:46 -0700 (PDT)
In-Reply-To: <1270749249-14041-5-git-send-email-nm@ti.com> (Nishanth Menon's message of "Thu\,  8 Apr 2010 12\:54\:09 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Govindraj R <govindraj.raja@ti.com>, Tero Kristo <tero.kristo@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> Remove the following sparse warnings by declaring attr as static:
> arch/arm/mach-omap2/serial.c:627:1: warning: symbol 'dev_attr_sleep_timeout' was not declared. Should it be static?
>
> Cc: Govindraj R <govindraj.raja@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tero Kristo <tero.kristo@nokia.com>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, adding to pm-next, queing for 2.6.35.

Kevin

> ---
>  arch/arm/mach-omap2/serial.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index c7b2326..cea0a9e 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -624,7 +624,8 @@ static ssize_t sleep_timeout_store(struct device *dev,
>  	return n;
>  }
>  
> -DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
> +static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
> +		sleep_timeout_store);
>  #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
>  #else
>  static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
> -- 
> 1.6.3.3
