From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 1/4] gpiolib: introduce set_debounce method
Date: Wed, 31 Mar 2010 14:46:28 +0100
Message-ID: <20100331134627.GA27613@sirena.org.uk>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com> <1270038435-28106-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:34315 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284Ab0CaNqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 09:46:35 -0400
Content-Disposition: inline
In-Reply-To: <1270038435-28106-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 03:27:12PM +0300, Felipe Balbi wrote:
> Few architectures, like OMAP, allow you to set
> a debouncing time for the gpio before generating
> the IRQ. Teach gpiolib about that.

More than a few, I suspect, and certainly some off-CPU GPIO controllers.

> +int gpio_set_debounce(unsigned gpio, int value)
> +{

What are the intended semantics of value here?
