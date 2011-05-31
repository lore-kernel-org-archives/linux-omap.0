From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] omap: rx51: Don't power up speaker amplifier at
 bootup
Date: Tue, 31 May 2011 00:27:08 -0700
Message-ID: <20110531072708.GK11352@atomide.com>
References: <1305199858-32643-1-git-send-email-jhnikula@gmail.com>
 <1305199858-32643-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37067 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751368Ab1EaH1L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 03:27:11 -0400
Content-Disposition: inline
In-Reply-To: <1305199858-32643-2-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

* Jarkko Nikula <jhnikula@gmail.com> [110512 04:26]:
> Speaker amplifier is accidentally powered up in early TWL gpio setup. This
> causes a few mA of needless battery current consumption. Without this patch
> the amplifier can be shutdown only by having one active audio playback and
> shutdown cycle to speaker output.
> 
> Thanks to Kalle Jokiniemi <kalle.jokiniemi@nokia.com> for noticing the issue.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 8242e99..0374562 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -561,7 +561,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
>  	gpio_request(gpio + 6, "backlight_pwm");
>  	gpio_direction_output(gpio + 6, 0);
>  	gpio_request(gpio + 7, "speaker_en");
> -	gpio_direction_output(gpio + 7, 1);
> +	gpio_direction_output(gpio + 7, 0);
>  
>  	return 0;
>  }

Jarkko care to rebase this on current -rc1?

Tony
