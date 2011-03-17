From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/4] OMAP: DMA: mstandby mode and runtime pm support
Date: Thu, 17 Mar 2011 14:29:18 -0700
Message-ID: <87lj0dwi4x.fsf@ti.com>
References: <1299853215-8507-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56663 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755572Ab1CQV3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 17:29:22 -0400
Received: by mail-iy0-f182.google.com with SMTP id 12so5327902iyj.27
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 14:29:21 -0700 (PDT)
In-Reply-To: <1299853215-8507-1-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Fri, 11 Mar 2011 19:50:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, paul@pwsan.com, tony@atomide.com

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Patch series to support mstandby mode handling and enabling runtime PM
> support for DMA driver.

I still have the same problems as with the previous revision: 


This is still not runtime-suspending when I use my DMA test in linking
mode.

If I put a large enough period between transfers, it should autosuspend
during transfers.  It seems to do auto-suspend and resume once, but then
it never suspends again.

I tested with my dmatest module[1], and loaded with:

  # insmod ./dmatest.ko linking=1 forever=1 forever_period=1024

Not only does it not auto-suspend between transfers (which I expected),
it also doesn't suspend after removing the module which stops all active
channels.

Kevin

