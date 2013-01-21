From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Mon, 21 Jan 2013 10:01:14 -0800
Message-ID: <20130121180113.GA22517@atomide.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
 <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com>
 <20130118171500.GC15361@atomide.com>
 <50FCF838.6000105@ti.com>
 <50FD5993.5010008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58103 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752458Ab3AUSBS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 13:01:18 -0500
Content-Disposition: inline
In-Reply-To: <50FD5993.5010008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, rnayak@ti.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130121 07:09]:
> >
> So I looked at this one with help of Rajendra. We can get rid of the
> IRQ and DMA data(needs DMA biding updates) easily. The address
> space though is needed since hwmod code uses it to setup the
> sysconfig registers.

OK great. The address space tinkering in hwmod code should be
moved to be done in the drivers.

As discussed earlier, there should be a driver specific reset
function driver_xyz_reset() in the driver header file so the
hwmod code can call it too in a late_initcall if no driver is
loaded.

> Extracting that from DT code seems to be really expensive and
> ugly [1]. I am yet to try out DMA lines removal but that seems
> to be doable by pulling Vinod'd DMA engine branch and updating
> DT file.

The overhead here does not matter as it should only happen in a
late_initcall and only for some of the drivers. For that to
happen we just need to go through the list of modules not yet
probed. We also need to have some locking in the driver specific
reset function to avoid races with the loadable modules.

> Whats your suggestion on address space part ?

Let's add the code to hwmod to extract it from DT so hwmod code
can call the driver specific reset function defined in the driver
header. That way we can start moving the driver code out of hwmod
one driver at a time.

Note that the ioremapping should be done in the driver specific
reset function, not in hwmod code. We just need to pass the
iorange in a struct resource to the driver specific reset function.

Regards,

Tony
