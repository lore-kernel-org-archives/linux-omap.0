From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce
	method
Date: Thu, 1 Apr 2010 19:15:08 +0100
Message-ID: <20100401181508.GA26650@opensource.wolfsonmicro.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com> <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com> <y2o6ed0b2681004010229r367aa72fv33746375541cd9da@mail.gmail.com> <20100401093239.GH16297@nokia.com> <o2x359ed6811004010611x718d76b2l8a5f2ea54b377c0e@mail.gmail.com> <20100401164249.GA3814@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34096 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754242Ab0DASPL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 14:15:11 -0400
Content-Disposition: inline
In-Reply-To: <20100401164249.GA3814@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, felipe.balbi@nokia.com, ext Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Apr 01, 2010 at 07:42:50PM +0300, Felipe Balbi wrote:
> On Thu, Apr 01, 2010 at 04:11:27PM +0300, Jani Nikula wrote:

> > You might want to have a look at [1] on irq debouncing. The hardware
> > support for debouncing varies (bank/gpio restrictions, debounce
> > timeouts, no support at all, what else?) so how can the users of this
> > interface rely on debouncing? What are the guarantees? AFAICS e.g.
> > gpio-keys would have to do software debouncing anyway.

> I think we could provide a generic software debouncing mechanism, sure,
> but if the hardware supports it, why not using ?

I tend to agree here, especially for GPIOs on slow buses like I2C or
which may be used as wake sources.  I guess ideally we want something
like the LEDs do with blinking where we use the hardware feature if
present and suitable but fall back on software emulation transparently
if it's not available or can't be configured appropriately.
