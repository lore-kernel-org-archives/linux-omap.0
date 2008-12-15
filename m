From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 15:56:03 +0200
Message-ID: <20081215135603.GE16316@gandalf.research.nokia.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com> <20081215132210.GC16316@gandalf.research.nokia.com> <1229348645.5895.279.camel@jani-desktop>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51941 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbYLOOBM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 09:01:12 -0500
Content-Disposition: inline
In-Reply-To: <1229348645.5895.279.camel@jani-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, juha.yrjola@solidboot.com

On Mon, Dec 15, 2008 at 03:44:05PM +0200, Jani Nikula wrote:
> That's a nice idea, but gpio_sw_irq_handler() actually supports having 0
> debounce timeouts, i.e. no settling time. Of course, I could use -1 for
> "don't update". However, the semantics above is exactly the same as in
> add_board_switches() for the update case. I'm not sure if it would be a
> good idea to deviate from this - what do you think? 

makes sense to me. But then again, if the uses does something like:

static struct omap_gpio_switch *cfg;

static int __init blabla_probe(struct platform_device *dev)
{
	cfg = kmalloc(sizeof(cfg), GFP_KERNEL));

	cfg->notify = my_notify;

	omap_update_gpio_swtich(cfg);

	return 0;
};

that means that if cfg->debounce_rising was different than 0, it'll get
overwritten to 0, right ? So, at least, you should put a big note for
users to initialize all necessary fields. Or, again, you only change if
cfg-><whatever> is different than 0 (or NULL), but that could a problem
when you really wanna change cfg->debounce_rising from, say, 100 to 0.
That wouldn't happen :-p

-- 
balbi
