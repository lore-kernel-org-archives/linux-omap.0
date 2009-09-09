From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: Lock DPLL5 at boot
Date: Wed, 9 Sep 2009 09:43:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0909090939420.8657@utopia.booyaka.com>
References: <1252418056-5994-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44615 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbZIIPn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 11:43:27 -0400
In-Reply-To: <1252418056-5994-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, b-cousson@ti.com

On Tue, 8 Sep 2009, Anand Gadiyar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> OMAP3: Lock DPLL5 at boot
> 
> Lock DPLL5 at 120MHz at boot. The USBHOST 120MHz f-clock and
> USBTLL f-clock are the only users of this DPLL, and 120MHz is
> is the only recommended rate for these clocks.
> 
> With this patch, the 60 MHz ULPI clock is generated correctly.
> 
> Tested on an OMAP3430 SDP.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
> Incorporated all 3 comments by Paul and Benoit. Updated
> $SUBJECT to reflect the change.

Thanks for the changes, I will queue this in a for-next branch for .33.


- Paul
