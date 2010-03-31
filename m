From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH 1/4] gpiolib: introduce set_debounce method
Date: Wed, 31 Mar 2010 16:04:03 +0100
Message-ID: <20100331150402.GB12394@rakim.wolfsonmicro.main>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270038435-28106-2-git-send-email-felipe.balbi@nokia.com>
 <20100331134627.GA27613@sirena.org.uk>
 <20100331145059.GA3833@gandalf>
 <20100331145919.GB6503@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45432 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752510Ab0CaPEI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 11:04:08 -0400
Content-Disposition: inline
In-Reply-To: <20100331145919.GB6503@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 31, 2010 at 05:59:19PM +0300, Felipe Balbi wrote:
> On Wed, Mar 31, 2010 at 04:50:59PM +0200, ext Felipe Balbi wrote:

> >debounce time. I just used value because other functions also call it

> oh yeah, in miliseconds.

> >value.

> maybe we could call it debounce. And switch to unsigned. Calling
> gpio_set_debounce() with a 0 debounce time should disable it, btw.

Sounds reasonable, a comment would help also.
