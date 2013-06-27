From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] am33xx: create child nodes for the two musb controllers
Date: Thu, 27 Jun 2013 13:44:34 +0200
Message-ID: <51CC25A2.3080808@linutronix.de>
References: <20130626153325.GA24075@linutronix.de> <51CC20CF.2080103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40413 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab3F0Log (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 07:44:36 -0400
In-Reply-To: <51CC20CF.2080103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 06/27/2013 01:23 PM, Benoit Cousson wrote:
> Hi Sebastian,

Hi Benoit,

> BTW, why do have so many DMA compared to the previous version?
I added them, the previous had none and is PIO only.
I currently use three cells per dma channel (the posted example had
two).
In general I think I have to request 2 * 15 dma channels for the 15 TX
and RX endpoints. So we end up with 30 channels per device (and we have
two of them).
The DMA engine has specific queues which depend on the USB endpoint
that is used. Instead of hacking this information in some kind of
platform data I decided to push this detail into device tree.

> I don't know the HW in detail, but that looks indeed much better and
> seems to reflect the partitioning with multiple instances accurately.
> 
> If Felipe is OK with that partitioning, I'll take it.

Okay, thanks.

> 
> Thanks,
> Benoit

Sebastian
