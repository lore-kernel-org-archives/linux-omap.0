From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V5 1/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC
 timer to prcm-common header
Date: Thu, 26 Apr 2012 13:25:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204261325380.10308@utopia.booyaka.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com> <1335362340-14960-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45305 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab2DZTZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 15:25:49 -0400
In-Reply-To: <1335362340-14960-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

On Wed, 25 Apr 2012, Vaibhav Hiremath wrote:

> Add missing idle_st bit for 32k-sync timer into the prcm-common
> header file, required for hwmod data.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> NOTE: This patch is same as first version, without any code changes.

Thanks, queued for 3.5.


- Paul
