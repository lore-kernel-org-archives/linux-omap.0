From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP: Beagle: revision detection
Date: Tue, 17 Aug 2010 08:48:24 +0300
Message-ID: <20100817084824.8f869e8e.jhnikula@gmail.com>
References: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33799 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0HQFsR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 01:48:17 -0400
Received: by eyg5 with SMTP id 5so1733921eyg.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Aug 2010 22:48:16 -0700 (PDT)
In-Reply-To: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi

On Mon, 16 Aug 2010 09:36:41 -0500
Robert Nelson <robertcnelson@gmail.com> wrote:

> +u8 get_omap3_beagle_rev(void)
> +{
> +	return omap3_beagle_version;
> +}
> +
> +static void __init omap3_beagle_get_revision(void)
> +{
> +	int ret;
> +	u16 beagle_rev = 0;
> +
> +	omap_mux_init_gpio(171, OMAP_PIN_INPUT_PULLUP);
> +	omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
> +	omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);
> +
> +	ret = gpio_request(171, "rev_id_0");
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = gpio_request(172, "rev_id_1");
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = gpio_request(173, "rev_id_2");
> +	if (ret < 0)
> +		goto fail;
> +

Sorry, I didn't notice this earlier: you should free already allocated
gpios if the next one fails.

<minor>
I was thinking would it make a sense to rename funtions below. I.e. to
indicate that only one of them is for runtime revision detection and
another is for revision initialization only. What do you think?

get_omap3_beagle_rev -> omap3_beagle_get_rev
omap3_beagle_get_revision -> omap3_beagle_init_rev
</minor>

Otherwise the set looks goot to me.


-- 
Jarkko
