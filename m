From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 15:40:10 +0200
Message-ID: <20081215134010.GA10709@mail.solidboot.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:44714 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbYLOOL2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Dec 2008 09:11:28 -0500
Content-Disposition: inline
In-Reply-To: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, Dec 15, 2008 at 02:08:16PM +0200, Jani Nikula wrote:

> Add new function omap_update_gpio_switch() to support dynamically
> changing the GPIO switch notify callback functions and debounce
> timeouts.

Why do they need to be changed? GPIO switches related to the board schematics,
which do not hopefully change dynamically.

> +	spin_lock_irqsave(&sw->lock, flags);
>  	if (state)
>  		timeout = sw->debounce_rising;
>  	else
>  		timeout = sw->debounce_falling;
> +	spin_unlock_irqrestore(&sw->lock, flags);

What's the point of this? The above read can be consider an atomic operation.

> +	spin_lock_irqsave(&sw->lock, flags);
> +	notify = sw->notify;
> +	notify_data = sw->notify_data;
> +	spin_unlock_irqrestore(&sw->lock, flags);
> +
> +	if (notify != NULL)
> +		notify(notify_data, state);

What if omap_update_gpio_switch() is called just before the check for
notify != NULL from another (hypothetical =)) CPU? Then you end up with the
function completing, but still having the old notify callback called with
old notify_data.

Cheers,
Juha
