From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] CBUS Patches
Date: Tue, 14 Jun 2011 03:06:43 -0700
Message-ID: <20110614100643.GM3352@atomide.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:15328 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755908Ab1FNKGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 06:06:46 -0400
Content-Disposition: inline
In-Reply-To: <1307994058-25486-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110613 12:36]:
> Hi Tony,
> 
> the following two patches get rid of
> the static global variable holding the
> bus context. It's not needed at all.
> 
> This will allow us to have multiple
> CBUS buses by using different GPIOs.
> 
> Will never be useful, but that's it
> should've been done anyway :-p

OK cool applying to cbus branch.

Tony
