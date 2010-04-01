From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCHv2 2/4] arm: omap: gpio: implement set_debounce
 method
Date: Thu, 1 Apr 2010 12:32:39 +0300
Message-ID: <20100401093239.GH16297@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
 <1270049712-28272-3-git-send-email-felipe.balbi@nokia.com>
 <y2o6ed0b2681004010229r367aa72fv33746375541cd9da@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57510 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0DAJdb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:33:31 -0400
Content-Disposition: inline
In-Reply-To: <y2o6ed0b2681004010229r367aa72fv33746375541cd9da@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, Apr 01, 2010 at 11:29:16AM +0200, ext Grazvydas Ignotas wrote:
>Hmh, dbck is shared by the whole GPIO bank, so what happens if someone
>calls _set_gpio_debounce(bank, 1, 310) and then
>_set_gpio_debounce(bank, 2, 0)? This should leave debounce enabled for
>GPIO1, but you'll disable dbck on second call. GPIOs 0-31 share the
>same bank.

but why would you call _set_gpio_debounce(bank, 2 0); without setting a 
real debounce value before ?

>There is also an issue if somebody calls _set_gpio_debounce(bank, 1,
>310) and _set_gpio_debounce(bank, 2, 620), the second call will
>override debounce setting of GPIO1 (as it's shared by the whole bank).
>This might be not what the user intended, would be useful to detect
>this and warn the user.

good point. As this is RFC, I'll wait until everybody comments.

-- 
balbi
