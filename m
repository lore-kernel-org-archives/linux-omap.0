From: "Andrew Tverdohlebov" <fat031c@gmail.com>
Subject: Re: gpio irq on Beagleboard
Date: Fri, 16 Apr 2010 15:59:19 +1100
Message-ID: <8A909C07C62544C9924984F81D5F4FBA@rhonda.vtc.ru>
References: <38B49E6266DD4380903FF7A5E6162A5D@rhonda.vtc.ru>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:56878 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab0DPE7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 00:59:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so66399fga.1
        for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 21:59:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dear linux-omap community,

I am writing a simple driver for BeagleBoard
and trying to get an understanding of how interrupts work.
 
Could you please answer a small question. What is a difference between irq 
 and virtual_irq_start in structure gpio_bank in file 
 arch/arm/plat-omap/gpio.c
 As far as I understood irq corresponds to real hardware interrupts while 
 virtual_irq_start is completely obscure for me.
 I didn't find a clue in the documentation.
 
 
 Any tiny help will be hugely appreciated.
Andrew 
 
