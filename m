From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: GPIO: Enable debounce clock only when debounce
	is enabled v3.
Date: Thu, 25 Sep 2008 13:28:09 +0300
Message-ID: <20080925102808.GH5222@atomide.com>
References: <alpine.DEB.1.00.0809160633320.21341@utopia.booyaka.com> <1221569504-26760-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.1.00.0809160656360.21341@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51068 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbYIYK2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 06:28:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0809160656360.21341@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@booyaka.com> [080916 16:02]:
> On Tue, 16 Sep 2008, Jouni Hogander wrote:
> 
> > This patch changes gpio "driver" to enable debounce clock for
> > gpio-bank only when debounce is enabled for some gpio in that bank.
> > 
> > Gpio functional clocks are also renamed in clock tree, gpioX_fck ->
> > gpioX_dbck.
> > 
> > This patch triggers problem with gpio wake-up and Omap3. Gpios in PER
> > domain aren't capable to generate wake-up if PER domain is in sleep
> > state. For this iopad wake-up should be used and needed pad
> > configuration should be done. Enabling iopad wake-up for gpio pads is
> > left for bootloader or omap mux configuration in kernel.
> > 
> > Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing today.

Tony
