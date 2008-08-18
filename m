From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [MTD] OneNAND OMAP3: add delay for GPIO
Date: Mon, 18 Aug 2008 15:41:36 +0300
Message-ID: <20080818124135.GF17827@atomide.com>
References: <48A4103C.9090603@nokia.com> <20080818123319.GD17827@atomide.com> <1219063003.18027.5.camel@sauron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62315 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYHRMll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 08:41:41 -0400
Content-Disposition: inline
In-Reply-To: <1219063003.18027.5.camel@sauron>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind@infradead.org>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-omap@vger.kernel.org, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

* Artem Bityutskiy <dedekind@infradead.org> [080818 15:38]:
> 
> On Mon, 2008-08-18 at 15:33 +0300, Tony Lindgren wrote:
> > * Adrian Hunter <ext-adrian.hunter@nokia.com> [080814 14:21]:
> > > On OMAP3, the driver was occasionally not seeing the GPIO
> > > interrupt.  Adding a small delay of one register read
> > > eliminates the problem.
> > 
> > Pushing to linux-omap tree.
> 
> Note, dwmw2 pushed this to mtd tree already:
> 
> http://git.infradead.org/mtd-2.6.git?a=commit;h=782b7a367d81da005d93b28cb00f9ae086773c24

OK good, I'll be using whatever drops down from mainline for MTD files.

So just pushing the fix to linux-omap to wait for it to drop down from
mainline.

Regards,

Tony
