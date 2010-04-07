From: Kan-Ru Chen <kanru@0xlab.org>
Subject: Re: [PATCH 1/2] Enable DVI-D output for Devkit8000
Date: Wed, 07 Apr 2010 16:26:00 +0800
Message-ID: <87wrwjr7mv.fsf@anar.kanru.info>
References: <1270613370-4135-1-git-send-email-kanru@0xlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:52688 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab0DGIZx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 04:25:53 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1NzQa3-00010r-9o
	for linux-omap@vger.kernel.org; Wed, 07 Apr 2010 08:25:49 +0000
In-Reply-To: <1270613370-4135-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kan-Ru Chen <kanru@0xlab.org>, Thomas Weber <weber@corscience.de>

On Wed,  7 Apr 2010 12:09:29 +0800, Kan-Ru Chen <kanru@0xlab.org> wrote:
> @@ -283,6 +289,12 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
>  	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>  	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>  
> +	/* gpio + 7 is "DVI_PUD" (out, active low) */
> +	devkit8000_dvi_device.reset_gpio = gpio + 7;
> +	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI_PUD");
> +	/* Disable until needed */
> +	gpio_direction_output(devkit8000_dvi_device.reset_gpio, 1);
> +
>  	return 0;
>  }

Sorry for the noise, it seems I misconfigured this pin. It's actually
active high. So the initial value should be 0 to disable it. I will
prepare a new patch about this.

And seems the second patch doesn't effect the LCD state at all. I have
no idea, but the patch can be dropped.

Cheers,
              Kanru
-- 
Kan-Ru Chen | http://kanru.info

Q: Why are my replies five sentences or less?
A: http://five.sentenc.es/
