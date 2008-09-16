From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH] OMAP3: GPIO: Enable debounce clock only when debounce
 is enabled v3.
Date: Tue, 16 Sep 2008 06:59:10 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809160656360.21341@utopia.booyaka.com>
References: <alpine.DEB.1.00.0809160633320.21341@utopia.booyaka.com> <1221569504-26760-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37833 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbYIPM7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:59:12 -0400
In-Reply-To: <1221569504-26760-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, 16 Sep 2008, Jouni Hogander wrote:

> This patch changes gpio "driver" to enable debounce clock for
> gpio-bank only when debounce is enabled for some gpio in that bank.
> 
> Gpio functional clocks are also renamed in clock tree, gpioX_fck ->
> gpioX_dbck.
> 
> This patch triggers problem with gpio wake-up and Omap3. Gpios in PER
> domain aren't capable to generate wake-up if PER domain is in sleep
> state. For this iopad wake-up should be used and needed pad
> configuration should be done. Enabling iopad wake-up for gpio pads is
> left for bootloader or omap mux configuration in kernel.
> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
