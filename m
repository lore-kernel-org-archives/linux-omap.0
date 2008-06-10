From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] PRCM: OMAP3: Fix to wrongly modified
	omap2_clk_wait_ready
Date: Tue, 10 Jun 2008 12:01:53 -0700
Message-ID: <20080610190151.GI23796@atomide.com>
References: <1213003960-900-1-git-send-email-jouni.hogander@nokia.com> <alpine.DEB.1.00.0806091810350.13214@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:61611 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbYFJTB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 15:01:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806091810350.13214@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080609 17:11]:
> On Mon, 9 Jun 2008, Jouni Hogander wrote:
> 
> > omap2_clk_wait_ready was wrongly modified to check
> > registers contents. This fix changes it back to check
> > addresses.
> > 
> > Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing today.

Tony
