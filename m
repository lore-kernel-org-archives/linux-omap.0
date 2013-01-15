From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 2/5] mtd: omap-nand: pass device_node in platform
 data
Date: Tue, 15 Jan 2013 11:26:25 -0800
Message-ID: <20130115192624.GD14149@atomide.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
 <1355481404-27695-3-git-send-email-zonque@gmail.com>
 <20130115185251.GB14149@atomide.com>
 <1358276967.1668.0.camel@kyv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:56932 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752720Ab3AOT0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jan 2013 14:26:32 -0500
Content-Disposition: inline
In-Reply-To: <1358276967.1668.0.camel@kyv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>, linux-mtd@lists.infradead.org

* Artem Bityutskiy <dedekind1@gmail.com> [130115 11:12]:
> On Tue, 2013-01-15 at 10:52 -0800, Tony Lindgren wrote:
> > Artem,
> > 
> > Looks like this patch related to making GPMC work with DT was
> > never sent to linux-mtd or to you so adding to cc.
> > 
> > Is this OK to apply along with the GPMC patches, or do you want to
> > take this separately with the MTD patches?
> 
> Please, go ahead!

OK thanks. Can I add your Acked-by too?

Tony
