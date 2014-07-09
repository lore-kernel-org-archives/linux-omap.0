From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] arm: dts: dra7: fixup qspi entry
Date: Wed, 9 Jul 2014 03:26:56 -0700
Message-ID: <20140709102655.GN28884@atomide.com>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
 <1404844852-19980-3-git-send-email-bigeasy@linutronix.de>
 <53BD1444.6080603@ti.com>
 <53BD16F6.1030006@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53851 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114AbaGIK0z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 06:26:55 -0400
Content-Disposition: inline
In-Reply-To: <53BD16F6.1030006@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: sourav <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140709 03:20]:
> On 07/09/2014 12:07 PM, sourav wrote:
> > Hi,
> 
> Hello, Sourav,
> 
> > The number is correct and is complaining just because the crossbar stuff
> > is not
> > put in. I had already posted a patch[1] to remove interrupt binding as
> > of now.
> > 
> > Hence, NAK for this patch.
> 
> Thank you for explanation. What is the status on the crossbar stuff? Is
> this comming any time soon? It seems that it is also stalling the
> networking pieces.

The drivers/irqchip related fixes are queued into linux next,
and I'm planning to queue the dts related changes for v3.17.

I might have the crossbar stuff in omap-for-v3.17/dt at some
point today.

Regards,

Tony

> > [1]: https://patchwork.kernel.org/patch/4364341/
