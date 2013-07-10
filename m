From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] pinctrl single support for SoC specific features
Date: Wed, 10 Jul 2013 05:24:17 -0700
Message-ID: <20130710122417.GT5523@atomide.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <51DD4F30.7050603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54271 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3GJMYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 08:24:20 -0400
Content-Disposition: inline
In-Reply-To: <51DD4F30.7050603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linus.walleij@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Roger Quadros <rogerq@ti.com> [130710 05:16]:
> Hi Tony,
> 
> On 06/07/2013 11:50 PM, Tony Lindgren wrote:
> > Hi all,
> > 
> > Here are few patches to add support for SoC specific features
> > to pinctrl-single. This is needed at least for omaps to support
> > IO chain wake-up events from deeper idle states.
> > 
> > With this patch series, device drivers can request named pinctrl
> > states like active and idle from the PM runtime suspend and resume
> > calls to set the wake enable bits for selected pins. Further
> > the device driver can toggle the wake-up feature as needed based on
> > the device_may_wakeup() state set by the standard sysfs
> > power/wakeup entry.
> > 
> > This is implemented in a separate pinctrl-single-omap driver that
> > works together with pinctrl-single. This way the SoC specific
> > are separated from the common pinctrl-single, and allows a relatively
> > easy way to implement SoC specific things like wake-up events,
> > pin interrupts, and GPIO.
> 
> What's the status of this? Would be nice to get it in 3.12. I'm basing
> the OMAP USB host wakeup support on this.

How about I'll push an immutable branch against v3.11-rc1 when it's
tagged and send a pull request to Linus W for the first three patches?

That way we can base other branches on this if needed.

Linus, does that sound OK to you?

Regards,

Tony
