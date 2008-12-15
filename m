From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 17:29:20 +0200
Message-ID: <20081215152920.GA11007@mail.solidboot.com>
References: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com> <20081215134010.GA10709@mail.solidboot.com> <1229352752.5895.325.camel@jani-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:50089 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbYLOP3V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Dec 2008 10:29:21 -0500
Content-Disposition: inline
In-Reply-To: <1229352752.5895.325.camel@jani-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Mon, Dec 15, 2008 at 04:52:32PM +0200, Jani Nikula wrote:

> > Why do they need to be changed? GPIO switches related to the board schematics,
> > which do not hopefully change dynamically.
> 
> The switches themselves don't change (nor does this patch support
> changing them), but different kinds of external devices may be connected
> to the GPIO swiches. It would be useful to be able to change the
> notification callbacks and debounce timeouts according to the device.

Could you give an example use-case? If the gpio-switch framework starts
getting extended and used more, it might be sensible to convert it to
the general GPIO API, as Trilok suggested.

> Umm, I suppose I was more worried that the write might not be an atomic
> operation, messing up the read as well. But I'll take your word for it
> if you say the write is okay. :)

Integer reads/writes are atomic, unless the system has some serious cache
coherency issues. And in that case, spinlocks won't save you either -- only
the HW engineers can. =)

> > What if omap_update_gpio_switch() is called just before the check for
> > notify != NULL from another (hypothetical =)) CPU? Then you end up with the
> > function completing, but still having the old notify callback called with
> > old notify_data.
>
> I was, of course, making sure a NULL pointer is not called and there's
> no mismatch between old/new notify/notify_data. Your scenario might
> theoretically actually occur on a single processor system as well, don't
> you think? 

Ah, yes. I was under the impression that gpio_sw_handler() was called from
IRQ context, but since it's a work handler, the function certainly can be
preempted.

> But is it actually a problem or not? And if yes, do you have any
> suggestions as to handling the case? If there's no need to lock for
> reading the debounce timeouts in gpio_sw_irq_handler() as you say above,
> do you think I could switch to a mutex and call notify callback holding
> that?

Especially in the case of frameworks, it's good to make things as correct
as possible. A mutex is safe.

Cheers,
Juha
