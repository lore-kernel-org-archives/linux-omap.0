From: Daniel Mack <zonque@gmail.com>
Subject: Re: omap_hsmmc: SDIO IRQ on AM335x family
Date: Fri, 30 Nov 2012 19:57:35 +0100
Message-ID: <50B9019F.2020109@gmail.com>
References: <20121130111847.GA24674@blumentopf> <20121130174022.GM5312@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34726 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2K3S5k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 13:57:40 -0500
In-Reply-To: <20121130174022.GM5312@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Hi Tony,
Hi Andreas,

On 30.11.2012 18:40, Tony Lindgren wrote:
> * Andreas Fenkart <andreas.fenkart@streamunlimited.com> [121130 03:21]:
>>
>> The alternative was to configure dat1 line as a GPIO, while
>> waiting for an IRQ. Then configuring it back as dat1 when the
>> SDIO card is signalling an IRQ. Or the host starts a transfer. I
>> guess this will perform poorly, hence not considering it really.
> 
> This might work for SDIO cards. It should be disabled for data
> cards naturally to avoid potential data corruption.
> 
> The way to implement this is set named states in the .dts file
> for the pins using pinctrl-single.c, then have the MMC driver
> request states "default" "active" and "idle" during the probe,
> then toggle between active and idle during the runtime.
> 
> As far as I remember the GPIO functionality does not need to
> be enabled, just muxing the pin to GPIO mode for the wake-up
> is enough.

Wouldn't that be racy, given that an interrupt which occurs at beween
the point in time when the driver decides to wait for IRQs again until
the mux has finished switching over, could potentially be lost?

If there is another way to solve that cleanly on at least some hardware
derivats, I'd say that should be preferred and be supported by the driver.


Daniel
