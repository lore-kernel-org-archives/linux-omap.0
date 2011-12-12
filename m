From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 00/14] PRCM chain handler
Date: Mon, 12 Dec 2011 11:56:57 +0200
Message-ID: <1323683817.31914.22.camel@sokoban>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
	 <87mxb1l6e2.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46660 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1LLJ5B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:57:01 -0500
In-Reply-To: <87mxb1l6e2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

On Fri, 2011-12-09 at 14:36 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Once more a new version, it was decided that the PRM driver will be
> > dropped for now, and we will have the chain handler support under
> > mach-omap2 directory. This will most likely be addressed in future.
> 
> Just to clarify for others: We decided that since the PRM driver is
> going to take some more time to sort out, we would at least get the
> chained IRQ support in now so we can unblock drivers that need it for
> wakeup support (like UART, USB host, etc.)
> 
> > Other than that, the code is pretty close to what was in version 9,
> > just location has changed from /drivers/mfd to /arch/arm/mach-omap2.
> >
> > Tested with omap3 beagleboard, with dynamic idle and suspend, both
> > retention and off. omap4 should not be an issue seeing the code is
> > close to what was in version 9.
> >
> > TEMP patches can be ignored, they are provided only for testing
> > purposes, and shall be replaced by uart runtime support.
> 
> Can you repost a series without the TEMP patches, and Cc
> linux-arm-kernel as well.
> 
> For testing purposes, you can make a branch available with the temp
> patches included, and mention it in the changelog.

Okay, I'll repost once I have fixed this version hopefully.

-Tero


