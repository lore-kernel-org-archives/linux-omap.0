From: Tony Lindgren <tony@atomide.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Wed, 21 May 2008 10:44:28 -0700
Message-ID: <20080521174426.GC23002@atomide.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com> <20080521154010.GY23002@atomide.com> <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49713 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936023AbYEURoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 13:44:25 -0400
Content-Disposition: inline
In-Reply-To: <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

* mohammed shareef <mdshareef@gmail.com> [080521 10:12]:
> i see the following lines in the omap-osk.c file regarding the uarts:
> 
> static struct omap_uart_config osk_uart_config __initdata = {
> 	.enabled_uarts = (1 << 0),
> };
> 
> 
> what does it mean? i want all my uarts (1,2,3) enabled. how do i have
> to modify the above line?

How about try .enabled_uarts = 3

Tony
