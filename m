From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3] [RFC] clk: introduce clk_associate
Date: Wed, 1 Oct 2008 08:51:46 -0700
Message-ID: <200810010851.47774.david-b@pacbell.net>
References: <1222857363-25055-1-git-send-email-felipe.balbi@nokia.com> <1222857363-25055-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:39955 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752089AbYJAPvu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 11:51:50 -0400
In-Reply-To: <1222857363-25055-2-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Wednesday 01 October 2008, Felipe Balbi wrote:
> +/**
> + * clk_associate - associates a user to a clock so device drivers don't
> + * have to care about clock names
> + *
> + * @id: clock id as defined in arch/arm/mach-omapX/clkxxxx.h
> + * @dev: device pointer for the clock user
> + * @f: a function for the clock (uart_[if]ck, musb_ick, ehci_[if]ck, etc)
> + */
> +void __init clk_associate(const char *id, struct device *dev, const char *f)

Heh.  I remember coming up with that same abstraction
for mach-at91/clock.c a few years back.  It seems to
have worked fairly well in that far simpler environment,
and I can't imagine why it wouldn't work here too.

The name might be confusing though, since it's not part
of the standard clk_*() interface ... and the name might
be needed there, eventually.

So mirroring "at91_clock_associate()" ... maybe this
should be "omap_clock_associate()" not "clk_associate()".

- Dave
