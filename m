From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM OMAP3: rx51_defconfig: enable support for gpio
	keys
Date: Fri, 30 Oct 2009 10:44:53 -0700
Message-ID: <20091030174453.GB7180@atomide.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com> <93e74e7b4be2dcdbc489c0c92987fc36ef0db447.1256907278.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56649 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717AbZJ3Rou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 13:44:50 -0400
Content-Disposition: inline
In-Reply-To: <93e74e7b4be2dcdbc489c0c92987fc36ef0db447.1256907278.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org, linux-input@vger.kernel.org

* Jani Nikula <ext-jani.1.nikula@nokia.com> [091030 06:38]:
> From: Jani Nikula <ext-jani.1.nikula@nokia.com>
> 
> Compile gpio_keys driver a module.
> 
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

This patch could be merged into 2/3.

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/configs/rx51_defconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
> index e7e3133..1559734 100644
> --- a/arch/arm/configs/rx51_defconfig
> +++ b/arch/arm/configs/rx51_defconfig
> @@ -784,7 +784,7 @@ CONFIG_INPUT_KEYBOARD=y
>  # CONFIG_KEYBOARD_XTKBD is not set
>  # CONFIG_KEYBOARD_NEWTON is not set
>  # CONFIG_KEYBOARD_STOWAWAY is not set
> -# CONFIG_KEYBOARD_GPIO is not set
> +CONFIG_KEYBOARD_GPIO=m
>  # CONFIG_INPUT_MOUSE is not set
>  # CONFIG_INPUT_JOYSTICK is not set
>  # CONFIG_INPUT_TABLET is not set
> -- 
> 1.6.5.2
> 
