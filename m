From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: i2c: Add i2c support on omap4 platform
Date: Tue, 2 Mar 2010 14:54:46 -0800
Message-ID: <20100302225445.GA14164@atomide.com>
References: <1266597180-25139-1-git-send-email-santosh.shilimkar@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E10AD@dbde02.ent.ti.com>
 <20100225214703.GJ28173@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF6C3@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C43BFC61@dbde02.ent.ti.com>
 <20100227204049.GK17041@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C43BFCFA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53431 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab0CBWxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 17:53:41 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C43BFCFA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, Cory Maccarrone <darkstar6262@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100227 21:28]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Sunday, February 28, 2010 2:11 AM
> > To: Shilimkar, Santosh
> > Cc: ben-linux@fluff.org; linux-omap@vger.kernel.org; linux-i2c@vger.kernel.org; Syed, Rafiuddin; Cory
> > Maccarrone; akpm@linux-foundation.org
> > Subject: Re: [PATCH] omap: i2c: Add i2c support on omap4 platform
> > 
> > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100226 20:05]:
> > > Tony,
> > > What we do with patch now? It's more almost 6 months that this patch is
> > > floating without merge.
> > 
> > Well first we should test it for all omaps. So let's add it into
> > omap-testing for a few days to make sure it does not break anything.
> > 
> > Then let's ask Ben to queue it.
> > 
> Ok with me.

I've tried it out and seems to work just fine on 2420. I've applied
it for testing into omap-testing (and master) branches now.

Would be nice to get an ack from people using 7xx too on this.

Acked-by: Tony Lindgren <tony@atomide.com>
