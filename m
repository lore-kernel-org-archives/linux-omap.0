From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 15:44:05 +0200
Message-ID: <1229348645.5895.279.camel@jani-desktop>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
	 <20081215132210.GC16316@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24672 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYLONn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 08:43:57 -0500
In-Reply-To: <20081215132210.GC16316@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org, juha.yrjola@solidboot.com

On Mon, 2008-12-15 at 15:22 +0200, Felipe Balbi wrote:
> Hi,
> 
> one comment below
> 
> On Mon, Dec 15, 2008 at 02:08:16PM +0200, ext Jani Nikula wrote:
> > +int omap_update_gpio_switch(const struct omap_gpio_switch *cfg)
> > +{
> > +	unsigned long flags;
> > +	struct gpio_switch *sw = find_switch(cfg->gpio, cfg->name);
> > +
> > +	if (!sw)
> > +		return -EINVAL;
> > +
> > +	spin_lock_irqsave(&sw->lock, flags);
> > +	sw->debounce_rising = cfg->debounce_rising;
> > +	sw->debounce_falling = cfg->debounce_falling;
> > +	sw->notify = cfg->notify;
> > +	sw->notify_data = cfg->notify_data;
> > +	spin_unlock_irqrestore(&sw->lock, flags);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(omap_update_gpio_switch);
> 
> how about you only change what's not null ?? then you could only change
> the notify callback and keep the same debounce_rising/falling ??

That's a nice idea, but gpio_sw_irq_handler() actually supports having 0
debounce timeouts, i.e. no settling time. Of course, I could use -1 for
"don't update". However, the semantics above is exactly the same as in
add_board_switches() for the update case. I'm not sure if it would be a
good idea to deviate from this - what do you think? 

Jani.


