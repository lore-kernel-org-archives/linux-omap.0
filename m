From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce
 method
Date: Thu, 1 Apr 2010 19:42:50 +0300
Message-ID: <20100401164249.GA3814@gandalf>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
 <y2o6ed0b2681004010229r367aa72fv33746375541cd9da@mail.gmail.com>
 <20100401093239.GH16297@nokia.com>
 <o2x359ed6811004010611x718d76b2l8a5f2ea54b377c0e@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56724 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663Ab0DAQmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 12:42:19 -0400
Content-Disposition: inline
In-Reply-To: <o2x359ed6811004010611x718d76b2l8a5f2ea54b377c0e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: felipe.balbi@nokia.com, ext Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Apr 01, 2010 at 04:11:27PM +0300, Jani Nikula wrote:
> On Thu, Apr 1, 2010 at 12:32, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> > On Thu, Apr 01, 2010 at 11:29:16AM +0200, ext Grazvydas Ignotas wrote:
> >>
> >> There is also an issue if somebody calls _set_gpio_debounce(bank, 1,
> >> 310) and _set_gpio_debounce(bank, 2, 620), the second call will
> >> override debounce setting of GPIO1 (as it's shared by the whole bank).
> >> This might be not what the user intended, would be useful to detect
> >> this and warn the user.
> >
> > good point. As this is RFC, I'll wait until everybody comments.
> 
> Hi Felipe -
> 
> You might want to have a look at [1] on irq debouncing. The hardware
> support for debouncing varies (bank/gpio restrictions, debounce
> timeouts, no support at all, what else?) so how can the users of this
> interface rely on debouncing? What are the guarantees? AFAICS e.g.
> gpio-keys would have to do software debouncing anyway.
> 
> [1] http://lkml.org/lkml/2008/9/24/325

I think we could provide a generic software debouncing mechanism, sure,
but if the hardware supports it, why not using ?

I believe Dave's approach is really good, this is just another way to do
it. The difference with this patch is that we have control over the
debouncing time.

-- 
balbi
