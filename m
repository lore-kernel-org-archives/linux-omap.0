From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
Date: Thu, 14 Feb 2013 21:56:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302142155520.11016@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58157 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934964Ab3BNV4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 16:56:18 -0500
In-Reply-To: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, 14 Feb 2013, Paul Walmsley wrote:

> va = dev->bus->iounmap( ... );

And this should simply be

dev->bus->iounmap( ... );

I regret the error...

- Paul
