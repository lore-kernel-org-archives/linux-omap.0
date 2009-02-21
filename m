From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Sat, 21 Feb 2009 04:39:24 +0200
Message-ID: <20090221023924.GD6224@gandalf>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44419 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZBUCj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 21:39:29 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 08:27:54PM -0600, Lopez Cruz, Misael wrote:
> Hi,
> 
> I'm interested in bringing headset detection feature for audio. The detection is done through TWL GPIO_2. How can I configure a GPIO pin to generate an interrupt? Is there any API? Could you please point out another driver using that functionality so I can use as reference?

gpio_request(GPIO_NUMBER, "Headset IRQ");
gpio_direction_input(GPIO_NUMBER);
request_irq(client->irq, lm8323_irq, flags | IRQF_SHARED, DRIVER_NAME, dev);

that should do it :-)

see that GPIO_NUMBER will be gpio_base + 2, base is board-specific

-- 
balbi
