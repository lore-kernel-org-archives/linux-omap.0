From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: gpio irq on Beagleboard
Date: Fri, 16 Apr 2010 08:13:17 +0300
Message-ID: <20100416051317.GB26263@nokia.com>
References: <38B49E6266DD4380903FF7A5E6162A5D@rhonda.vtc.ru>
 <8A909C07C62544C9924984F81D5F4FBA@rhonda.vtc.ru>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56604 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0DPFNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 01:13:38 -0400
Content-Disposition: inline
In-Reply-To: <8A909C07C62544C9924984F81D5F4FBA@rhonda.vtc.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Andrew Tverdohlebov <fat031c@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Apr 16, 2010 at 06:59:19AM +0200, ext Andrew Tverdohlebov wrote:
>Dear linux-omap community,
>
>I am writing a simple driver for BeagleBoard
>and trying to get an understanding of how interrupts work.
>
>Could you please answer a small question. What is a difference between irq
> and virtual_irq_start in structure gpio_bank in file
> arch/arm/plat-omap/gpio.c
> As far as I understood irq corresponds to real hardware interrupts while
> virtual_irq_start is completely obscure for me.
> I didn't find a clue in the documentation.

it's where the gpio irqs could be placed (numbering-wise) after the irq 
controller. I mean, if the irq controller has 192 irqs, gpio irqs have 
to be numbered 193, 194, 195, etc... so virtual_irq_base is that initial 
number.

hope I made myself clear enough :-p

if you take a look at the gpio_bank arrays on that same file and look at 
the fourth initialization, you can get a clue. Take a look at the 
IH_GPIO_BASE define, for example.

-- 
balbi
