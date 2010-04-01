From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement =?UTF-8?Q?set=5Fdebounce?=
 =?UTF-8?Q?=20method?=
Date: Thu, 01 Apr 2010 13:19:31 -0500
Message-ID: <72b63a30604df16edc5c4e959966a708@secure211.sgcpanel.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com> <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com> <y2o6ed0b2681004010229r367aa72fv33746375541cd9da@mail.gmail.com> <20100401093239.GH16297@nokia.com> <o2x359ed6811004010611x718d76b2l8a5f2ea54b377c0e@mail.gmail.com> <20100401164249.GA3814@gandalf> <20100401181508.GA26650@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54268 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab0DAST2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 14:19:28 -0400
In-Reply-To: <20100401181508.GA26650@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, felipe.balbi@nokia.com, ext Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, 1 Apr 2010 19:15:08 +0100, Mark Brown 
> I tend to agree here, especially for GPIOs on slow buses like I2C or
> which may be used as wake sources.  I guess ideally we want something
> like the LEDs do with blinking where we use the hardware feature if
> present and suitable but fall back on software emulation transparently
> if it's not available or can't be configured appropriately.

yes, and that's a matter of just putting together a little more code
on the default implementation of gpio_set_debounce() instead of
simply returning -ENOSYS.

-- 
balbi
