From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv6 19/19] ARM: OMAP4: hwmod data: I2C: add flag for context
 restore
Date: Tue, 10 Apr 2012 12:13:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204101212530.20894@utopia.booyaka.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com> <1334055397-899-20-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59679 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab2DJSNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 14:13:33 -0400
In-Reply-To: <1334055397-899-20-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Benoit Cousson <b-cousson@ti.com>

On Tue, 10 Apr 2012, Shubhrajyoti D wrote:

> Restore of context is not done for OMAP4. This patch
> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
> hwmod data which activates the restore for OMAP4.
> Currently the OMAP4 does not hit device off still the
> driver may have support for it.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Wamsley <paul@pwsan.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.5.  You can drop this from your series; it will 
likely cause merge conflicts if you don't.

- Paul
