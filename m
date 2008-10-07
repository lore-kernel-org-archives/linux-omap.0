From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 2/3] Debobs and ETK padconf implementation
Date: Tue, 7 Oct 2008 13:59:27 +0300
Message-ID: <20081007105927.GA4755@codecarver.research.nokia.com>
References: <1222873873-31760-1-git-send-email-peter.de-schrijver@nokia.com> <1222873873-31760-2-git-send-email-peter.de-schrijver@nokia.com> <1222873873-31760-3-git-send-email-peter.de-schrijver@nokia.com> <87tzboelfk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57506 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbYJGLAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 07:00:12 -0400
Content-Disposition: inline
In-Reply-To: <87tzboelfk.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

> 
> Intead of __gpio_set_value(), this should be 
> 
>   gpio_direction_output(ETK_GPIO(gpio), value);
> 
> Because otherwise, the default direction defaults to input.
> 

Yes. The user should set the direction to output by himself. The idea is
that the kernel code should always be able to toggle the output value,
but the person debugging the system can still control if the GPIO value
is visible to the outside world or not. So I don't think the kernel
should force the direction, at least not implicitly.

> > +int debug_gpio_get(unsigned gpio)
> > +{
> > +	if (!debobs_initialized)
> > +		return -EINVAL;
> > +
> > +	WARN_ON(gpio >= NUM_OF_DEBOBS_PADS);
> > +	if (gpio < NUM_OF_DEBOBS_PADS)
> > +		return __gpio_get_value(ETK_GPIO(gpio));
> 
> I thing this should just be gpio_get_value() (no underscores)  and 
> then <linux/gpio.h> included.  The OMAP-specific inlines will be used
> anyways, so no need to use the __gpio* calls.
> 

There is only gpio_get_value_cansleep, while I want this functionality
to be always available, also in interrupthandlers. __gpio_get_value
warns if it would sleep.

Cheers,

Peter.

-- 
goa is a state of mind
