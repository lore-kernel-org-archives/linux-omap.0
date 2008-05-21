From: Tony Lindgren <tony@atomide.com>
Subject: Re: enabling uart2 on omap5912 osk
Date: Wed, 21 May 2008 13:48:22 -0700
Message-ID: <20080521204822.GD23002@atomide.com>
References: <a1d91fa0805202342k706a4389h54b5b89178991d86@mail.gmail.com> <20080521154010.GY23002@atomide.com> <a1d91fa0805211012v607195f2we8cc373b5a54ae4@mail.gmail.com> <20080521174426.GC23002@atomide.com> <db841a1287fea2504e17c787c8e25940@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58248 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709AbYEUUsV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 16:48:21 -0400
Content-Disposition: inline
In-Reply-To: <db841a1287fea2504e17c787c8e25940@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: mohammed shareef <mdshareef@gmail.com>, omap <linux-omap@vger.kernel.org>, linux-omap-open-source@linux.omap.com

* Felipe Balbi <me@felipebalbi.com> [080521 12:37]:
> 
> 
> On Wed, 21 May 2008 10:44:28 -0700, Tony Lindgren <tony@atomide.com> wrote:
> > * mohammed shareef <mdshareef@gmail.com> [080521 10:12]:
> >> i see the following lines in the omap-osk.c file regarding the uarts:
> >>
> >> static struct omap_uart_config osk_uart_config __initdata = {
> >> 	.enabled_uarts = (1 << 0),
> >> };
> >>
> >>
> >> what does it mean? i want all my uarts (1,2,3) enabled. how do i have
> >> to modify the above line?
> > 
> > How about try .enabled_uarts = 3
> 
> this would enable only uarts 1 and 2, right?
> maybe it's enough :-p

Oh yeh, that's true :)

Tony
