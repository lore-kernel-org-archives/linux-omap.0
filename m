From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP gpiolib?
Date: Wed, 01 Jun 2011 07:36:44 -0700
Message-ID: <8762opk48z.fsf@ti.com>
References: <BANLkTikpOeH_xXLtdrmuN4KJcrdgONcP2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54366 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756600Ab1FAOgs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 10:36:48 -0400
Received: by mail-pw0-f51.google.com with SMTP id 9so63275pwi.24
        for <linux-omap@vger.kernel.org>; Wed, 01 Jun 2011 07:36:47 -0700 (PDT)
In-Reply-To: <BANLkTikpOeH_xXLtdrmuN4KJcrdgONcP2A@mail.gmail.com> (Brian
	Hutchinson's message of "Wed, 1 Jun 2011 08:33:21 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Hutchinson <b.hutchman@gmail.com>
Cc: linux-omap@vger.kernel.org

[adding linux-omap list]

Hello,

Brian Hutchinson <b.hutchman@gmail.com> writes:

> Hi Kevin,
>
> I caught part of the conversation on the ARM kernel list where it
> looks like gpiolib for OMAP was going to be targeted to 2.6.41 or
> something like that (going from memory).

Actually, the recent discussions were more about moving the OMAP driver into
drivers/gpio.  The OMAP GPIO driver already uses gpiolib.

> We have the C6A816x-evm (DDR2 version) and we have a custom board that
> should be here any day based on a DDR3 design.
>
> I just stepped up to the latest u-boot & kernel for the DDR3 EVM (PSP
> 04.00.00.10).  We need to use both the hardware spi (4 channels built
> into the c6a816x) and gpio spi.
>
> I've been helping a colleague here get the gpio spi going but he
> claims that he can't have gpio spi and hardware spi going at the same
> time.  He claims if he tries to use both at the same time he gets a
> kernel crash.
>
> So I guess my questions are:
> 1.  In the release notes of the TI kernel we have (2.6.37) it says
> gpio lib is added.  Is this the complete OMAP gpiolib support or are
> there still things missing that we may need to back port from a 2.6.41
> version?  I'm just trying to understand the roadmap and which tree I
> should be watching.  I've been in Arago land quite a bit lately and
> focusing on the git trees associated with that.

I'm not familiar with the TI PSP kernels, so any specific questions
should be addressed to the support channels for that kernel.

In mainline, there is nothing (significant) that is different between
.37 and .40 in OMAP GPIO support.  Both are using gpiolib.

> 2.  Can hardware spi & gpio spi be used at the same time?  Now that I
> think of ... in past projects I've used either/or ... never both at
> the same time.

I don't know without digging into the TERM and knowing which exact GPIO
pins and which SPI controller you're wanting to use, but GPIO pins are
most always mux'd with other pins, so it is common that use of specific
GPIO pins would prevent the use of some peripherals.

Hope that helps,

Kevin
