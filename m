From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP: Power on EHCI, serial, camera and DVI on
 beagleboard-xM
Date: Thu, 06 Jan 2011 12:29:10 -0600
Message-ID: <4D2609F6.8090204@ti.com>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org> <1292769735-54159-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38866 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752444Ab1AFS3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 13:29:13 -0500
Received: by mail-yx0-f170.google.com with SMTP id 11so6178144yxi.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 10:29:13 -0800 (PST)
In-Reply-To: <1292769735-54159-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen.kooi@gmail.com>
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Koen Kooi <koen@beagleboard.org>

Koen,
Apologies on a late response.

Koen Kooi had written, on 12/19/2010 08:42 AM, the following:
[...]
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index f1a8ede..4756ac7 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -297,13 +297,35 @@ static int beagle_twl_gpio_setup(struct device *dev,
[..]
> +
> +	 /* Power on DVI, Serial and PWR led */
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +		gpio_request(gpio + 1, "nDVI_PWR_EN");
> +		gpio_direction_output(gpio + 1, 0);
> +	}
earlier in this function, we do:
	gpio_request(gpio + 1, "EHCI_nOC");
   	gpio_direction_input(gpio + 1);
here we do
gpio_request(gpio + 1, "nDVI_PWR_EN");
gpio_direction_output(gpio + 1, 0);

I am confused. is gpio+1 input or output line? and what level should it 
be on?

-- 
Regards,
Nishanth Menon
