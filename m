From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DTS: omap4-sdp: Add regulator for LCD backlight
 (pwm-backlight)
Date: Thu, 5 Dec 2013 10:40:07 -0800
Message-ID: <20131205184007.GE26766@atomide.com>
References: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
 <5297164D.9060400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21581 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757154Ab3LESkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 13:40:13 -0500
Content-Disposition: inline
In-Reply-To: <5297164D.9060400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tomi.valkeinen@ti.com

* Sourav Poddar <sourav.poddar@ti.com> [131128 02:10]:
> On Thursday 28 November 2013 02:58 PM, Peter Ujfalusi wrote:
> >Since in DT booted kernel dummy regulators are no longer supported we need
> >to provide valid phandle for the regulator needed by the backlight.
> >On the board VBAT is used to power the LCD backlight(s).
> >
> >Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> >---
> >Hi,
> >
> >This patch is needed for 3.13 to get the LCD backlight to work again.
> Is this usage of power supply a mandatory requirement?
> 
> There is a thread which discusses this issue[1]:
> http://www.spinics.net/lists/arm-kernel/msg288215.html
> 
> According to the above, regulator framework have support in 3.13-rc1
> to returns
> a dummy  regulator if there is none specified in the dts data.
> Thierry told that there seems to be a bug in regulator in handling
> these case.
> 
> Though, I also posted a patch on pwm a couple of days ago[2]
> [2]: https://patchwork.kernel.org/patch/3246711/
> 
> I posted it without "power-supply" by testing it with the
> solution proposed in [1].
> If I dont use the solution[1], it fails for me also.

Hmm so if this is not needed, I'll mark this thread as read in
my inbox. If you guys need it please repost.

Regards,

Tony
