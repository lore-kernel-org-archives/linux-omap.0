From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 1/4] ARM: OMAP3: cpuidle: Remove unused MPU OSWR support
 code
Date: Fri, 20 Jul 2012 12:25:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207201222250.14390@utopia.booyaka.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com> <1342764284-8143-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36531 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab2GTSZW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 14:25:22 -0400
In-Reply-To: <1342764284-8143-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, t-kristo@ti.com

On Fri, 20 Jul 2012, Rajendra Nayak wrote:

> We do not support MPU OSWR on OMAP3. Get rid of the complex/multiple
> save_state handling in omap_sram_idle() and just use 2 save_state
> definitions
> 
> save_state = 1, all logic and memory lost, MPU hits OFF
> save_state = 0, nothing lost, MPU hits CSWR or shallower state
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

The code is certainly simpler, but I recall seeing patchsets in the past 
that implemented OSWR on OMAP3.  (Not sure which powerdomains it was 
implemented for.)  Do you know what the status of those patchsets are?

- Paul
