From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2.6.27-rc8 1/2] drivers/mfd/twl4030-core.c
Date: Thu, 2 Oct 2008 09:05:28 +0300
Message-ID: <20081002060521.GA7942@atomide.com>
References: <200810011144.20510.david-b@pacbell.net> <200810011453.26699.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59166 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbYJBGCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 02:02:40 -0400
Content-Disposition: inline
In-Reply-To: <200810011453.26699.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Samuel Ortiz <sameo@openedhand.com>, lkml <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081002 00:53]:
> On Wednesday 01 October 2008, David Brownell wrote:
> 
> > NOTE: this is the current code from the linux-omap tree.
> 
> This chip being used on a whole bunch of boards:
> 
>  - Gumstix Overo
>  - BeagleBoard.org
>  - Omap ZOOM (Labrador)
>  - OMAP 2430 and 3430 SDP,
>  - OMAP2 and OMAP3 EVM
>  - ... more (openpandora.org ?)
> 
> which will get much closer to "usable with mainline kernels"
> when their power management chip works in mainline!  :)

Cool. I'll post some patches against mainline kernel
for booting minimal omap3 boards within next few days.
So we should get at least beagle and overo booting
to some extent, maybe with serial and musb.

Tony
