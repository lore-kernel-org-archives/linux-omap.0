From: David Brownell <david-b@pacbell.net>
Subject: Re: Fwd: Re: [rtc-linux] [patch 2/3] rtc-twl4030 driver
Date: Mon, 20 Oct 2008 15:51:38 -0700
Message-ID: <200810201551.39189.david-b@pacbell.net>
References: <200810181213.18616.david-b@pacbell.net> <20081020223151.GD4197@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:23084 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753084AbYJTWvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 18:51:42 -0400
In-Reply-To: <20081020223151.GD4197@sortiz.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: linux-omap@vger.kernel.org, Alessandro Zummo <alessandro.zummo@towertech.it>

On Monday 20 October 2008, Samuel Ortiz wrote:
> I am pushing this code without MODULE_AUTHOR for now.
> I agree with Alessandro it would be nice to have it, but only if it's someone
> that could actually maintain it somehow. Are Dmitry or/and Alexandre good
> candidates for that ?

I won't speak for them ...

The OMAP community has, so far, tended to be fairly
good about pitching in to fix things that break; so
there may be less of a worry there.  I also know that
TI is trying to be a bit more "in the loop" with its
staff and mainline, so that should help a bit too.

Anyway, this driver "Just Works", so nothing else
could go wrong.  ;)

- Dave

p.s. I just noticed a boatload of genirq patches
     go upstream ... I suspect that at least the
     reference to NR_IRQS in that one patch will
     need to change.


