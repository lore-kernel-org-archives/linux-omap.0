From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data
 file
Date: Fri, 7 Jun 2013 18:10:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306071807510.7753@utopia.booyaka.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com> <20130607162927.GA3331@atomide.com> <20130607175005.GB3331@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47477 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977Ab3FGSKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 14:10:15 -0400
In-Reply-To: <20130607175005.GB3331@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

On Fri, 7 Jun 2013, Tony Lindgren wrote:

> I had to undo the following parts to avoid regressions on omap4sdp.
> Can you please follow up on fixing the related issues so the fixup
> won't be needed?

Well, I can't even test it at the moment.  So it's probably best for 
Santosh and Sricharan to fix those issues - they're the ones who are 
responsible for testing the patch before it's sent.  Unless there's
some specific reason why I'd be the best person to do it?



- Paul
