From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 15:22:10 +0200
Message-ID: <20081215132210.GC16316@gandalf.research.nokia.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22738 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYLONWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 08:22:50 -0500
Content-Disposition: inline
In-Reply-To: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, juha.yrjola@solidboot.com

Hi,

one comment below

On Mon, Dec 15, 2008 at 02:08:16PM +0200, ext Jani Nikula wrote:
> +int omap_update_gpio_switch(const struct omap_gpio_switch *cfg)
> +{
> +	unsigned long flags;
> +	struct gpio_switch *sw = find_switch(cfg->gpio, cfg->name);
> +
> +	if (!sw)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&sw->lock, flags);
> +	sw->debounce_rising = cfg->debounce_rising;
> +	sw->debounce_falling = cfg->debounce_falling;
> +	sw->notify = cfg->notify;
> +	sw->notify_data = cfg->notify_data;
> +	spin_unlock_irqrestore(&sw->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap_update_gpio_switch);

how about you only change what's not null ?? then you could only change
the notify callback and keep the same debounce_rising/falling ??

-- 
balbi
