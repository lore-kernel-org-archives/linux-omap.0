From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 0/6] add support for omap wake-up interrupts via pinctrl-single, take2
Date: Thu, 10 Oct 2013 14:47:30 -0700
Message-ID: <871u3spzm5.fsf@linaro.org>
References: <20131003054104.8941.88857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46699 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457Ab3JJVre (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 17:47:34 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so3371265pad.0
        for <linux-omap@vger.kernel.org>; Thu, 10 Oct 2013 14:47:34 -0700 (PDT)
In-Reply-To: <20131003054104.8941.88857.stgit@localhost> (Tony Lindgren's
	message of "Wed, 02 Oct 2013 22:42:08 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Here's a respin of the pinctrl-single related patches to use chained
> irq as suggested by Linus W earlier. This series does not try to
> provide any generic automated solution yet, but works by doing a
> request_irq() for the wake-up pin, so it should be flexible enough for
> both manual control and automated solution.

> This series removes the last nasty blocker for making omap3 to be
> device tree only without causing nasty PM regressions.

Indeed, I gave this a spin on several OMAP3 platforms with legacy boot
and ran through a series of retention and off-mode tests for idle and
suspend with both UART and RTC wakeups.  No regressions found.  So...

Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>

on 3530/beagle, 3730/beagle-xM, 3530/Overo, 3730/Overo STORM

Kevin
