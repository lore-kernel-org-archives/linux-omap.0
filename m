From: Tony Lindgren <tony@atomide.com>
Subject: Re: Trouble with newer kernels on Gumstix Overo boards
Date: Tue, 21 Jun 2011 10:22:22 +0300
Message-ID: <20110621072220.GA21159@atomide.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
 <ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
 <BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48271 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932233Ab1FUHW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 03:22:29 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Daniel Mack <zonque@gmail.com> [110617 18:06]:
> On Fri, Jun 17, 2011 at 4:03 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> >> console=ttyS2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
> >
> > Here is your problem. We now use the OMAP-serial driver for the UARTs.
> 
> Which breaks backward-compatibility with bootloaders set up for older
> kernels. Now I have to deploy kernels with CONFIG_CMDLINE_FORCE=y. Was
> that really necessary?

In most cases you can just setenv cmdline then saveenv in u-boot.

Who knows, maybe at some point we can make 8250.c behave with runtime PM
and Linux generic DMA API, but that might take a while before we get there :)

Regards,

Tony
