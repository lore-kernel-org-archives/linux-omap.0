From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] pinctrl single support for SoC specific features
Date: Mon, 29 Jul 2013 01:59:31 -0700
Message-ID: <20130729085930.GX7656@atomide.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <51DD4F30.7050603@ti.com>
 <20130710122417.GT5523@atomide.com>
 <CACRpkdYGHy0jZ0TD8NejiT6TaR3txmXHKgvS=JXBV1-74jZeGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17566 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751197Ab3G2I7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 04:59:33 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYGHy0jZ0TD8NejiT6TaR3txmXHKgvS=JXBV1-74jZeGw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Linus Walleij <linus.walleij@linaro.org> [130722 14:01]:
> On Wed, Jul 10, 2013 at 2:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > How about I'll push an immutable branch against v3.11-rc1 when it's
> > tagged and send a pull request to Linus W for the first three patches?
> >
> > That way we can base other branches on this if needed.
> >
> > Linus, does that sound OK to you?
> 
> OK but I still need to look closer at them as well, so no guarantee
> I will pull it...

Good comments, let's try to make it all transparent. I'll drop
my branch and will repost the patches when I have things working
using irqchip.

Regards,

Tony
