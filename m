From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCHv2 1/4] gpiolib: introduce set_debounce method
Date: Fri, 2 Apr 2010 13:34:54 +0100
Message-ID: <20100402123454.GD27613@sirena.org.uk>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com> <1270049712-28272-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:51604 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab0DBMfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 08:35:00 -0400
Content-Disposition: inline
In-Reply-To: <1270049712-28272-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 06:35:09PM +0300, Felipe Balbi wrote:
> Few architectures, like OMAP, allow you to set
> a debouncing time for the gpio before generating
> the IRQ. Teach gpiolib about that.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

This looks useful - for what it's worth

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
