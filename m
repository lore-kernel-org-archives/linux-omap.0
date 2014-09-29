From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Mon, 29 Sep 2014 10:50:42 +0200
Message-ID: <20140929085042.GA13952@ci00147.xsens-tech.local>
References: <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
 <54129F6C.7040508@linutronix.de>
 <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140917102812.GA20438@ci00147.xsens-tech.local>
 <20140921204100.GA10111@linutronix.de>
 <20140922092853.GH20438@ci00147.xsens-tech.local>
 <20140925151403.GH19396@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:49758 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaI2Iur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2014 04:50:47 -0400
Content-Disposition: inline
In-Reply-To: <20140925151403.GH19396@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On Thu, Sep 25, 2014 at 05:14:03PM +0200, Sebastian Andrzej Siewior wrote:
> * Frans Klaver | 2014-09-22 11:28:54 [+0200]:
> 
> >I guess then we'd still have to answer the question why the yocto build
> >calls set_termios() so often, but that's not on you then. Did you notice
> >it even changing settings? We might want to fix this even if the kernel
> >should be able to cope.
> 
> could you please test uart_v10_pre3? I dropped a few register sets and
> delayed the register update until TX-DMA is complete. I am traveling
> currently and have only my boneblack and it passes my limited testing.
> If it solves your problems, too then I would address Heikki's latest
> comments and prepare the final v10 (and I hope I didn't break beagle
> board in between).

This version fixes the console things for us. It also increases the
amount of data we can push over the serial port. If I push the data
towards our requirements, we're not there yet. I get the "too much work
for irq" notice still. However, I don't think you'd need to be fixing
that in this series (or at all). We had similar issues there with
omap-serial as well.

As far as I'm concerned, this is

Tested-by: Frans Klaver <frans.klaver@xsens.com>

Thanks,
Frans
