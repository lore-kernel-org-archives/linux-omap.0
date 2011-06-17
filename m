From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Overo: remove illegal extra call to overo_ads7846_init()
Date: Fri, 17 Jun 2011 09:03:20 -0700
Message-ID: <87r56sbg3b.fsf@ti.com>
References: <1308324110-21918-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46995 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754024Ab1FQQDY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 12:03:24 -0400
Received: by mail-iw0-f180.google.com with SMTP id 6so3517553iwn.39
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 09:03:23 -0700 (PDT)
In-Reply-To: <1308324110-21918-1-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Fri, 17 Jun 2011 17:21:50 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com

Daniel Mack <zonque@gmail.com> writes:

> Signed-off-by: Daniel Mack <zonque@gmail.com>

Thanks for fixing this, I noticed this recently too.

Please add a descriptive changelog.  For example, why is it duplcate?
where is it already done?  what commit added the extra call, what
problems does it cause, etc.

Also, your subject says 'illegal', but it's not really illegal.  It's just
wrong. :)   "remove duplcate call to..." is enough.

Thanks,

Kevin


> ---
>  arch/arm/mach-omap2/board-overo.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 175e1ab..110475f 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -568,7 +568,6 @@ static void __init overo_init(void)
>  	usb_musb_init(NULL);
>  	usbhs_init(&usbhs_bdata);
>  	overo_spi_init();
> -	overo_ads7846_init();
>  	overo_init_smsc911x();
>  	overo_display_init();
>  	overo_init_led();
