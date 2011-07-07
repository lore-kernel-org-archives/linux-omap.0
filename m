From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] OMAP: omap_device: Create clkdev entry for hwmod
 main_clk
Date: Thu, 7 Jul 2011 16:09:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107071607580.2647@utopia.booyaka.com>
References: <1309555101-21198-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34065 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab1GGWJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 18:09:09 -0400
In-Reply-To: <1309555101-21198-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Todd Poynor <toddpoynor@google.com>

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Extend the existing function to create clkdev for every optional
> clocks to add a well one "fck" alias for the main_clk of the
> omap_hwmod.
> It will allow to remove these static clkdev entries from the
> clockXXX_data.c file.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Todd Poynor <toddpoynor@google.com>

Thanks, this patch has been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'omap_device_a_3.1' branch.


- Paul
