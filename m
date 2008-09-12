From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [RFC] OMAP3: GPIO: Enable debounce clock only when debounce is
 enabled
Date: Fri, 12 Sep 2008 08:34:47 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809120832170.16867@utopia.booyaka.com>
References: <1221216698-22327-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40887 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYILOes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 10:34:48 -0400
In-Reply-To: <1221216698-22327-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Jouni,

On Fri, 12 Sep 2008, Jouni Hogander wrote:

> This patch changes gpio "driver" to enable debounce clock for
> gpio-bank only when debounce is enabled for some gpio in that bank.
> 
> This patch obsoletes "PM: Dynamic GPIO clock handling" patch. Nasty
> side effect is that gpios in per domain aren't capable to generate
> wake-up if per domain is in sleep state. Anyway keeping dbcks enabled
> all the time isn't either good way to workaround this problem. For
> this we need to use iopad wake-up. Currently enabling iopad wakeup
> mechanism for gpio pads is left for bootloader or kernel (depending
> which one does the configuration)

nice resolution to this issue!  Besides Daniel's change, also it would be 
good to rename the "functional" clocks in the clock tree to indicate that 
these are debounce clocks.  Perhaps to GPIOx_DBCLK?


- Paul
