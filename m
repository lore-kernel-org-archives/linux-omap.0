From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Thu, 28 May 2009 20:53:20 +0100
Message-ID: <20090528195320.GX20736@n2100.arm.linux.org.uk>
References: <20090519232905.12760.15490.stgit@localhost> <20090519233732.12760.34595.stgit@localhost> <20090525092911.GC28195@n2100.arm.linux.org.uk> <20090525142128.17675cl0tvdr0y1k@lidskialf.net> <20090525174055.127744136qxu9vk0@lidskialf.net> <20090528182047.GF32453@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53509 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758547AbZE1Txb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 15:53:31 -0400
Content-Disposition: inline
In-Reply-To: <20090528182047.GF32453@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, May 28, 2009 at 11:20:48AM -0700, Tony Lindgren wrote:
> > +int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
> > +	struct device *dev)
> > +{
> > +	struct clk *r = clk_get(dev, id);
> > +	struct clk_lookup *l;
> > +
> > +	if (!r)
> > +		return -ENODEV;
> > +
> > +	l = clkdev_alloc(r, alias, alias_dev_name);
> > +	clk_put(r);
> > +	if (!l)
> > +		return -ENODEV;
> > +	clkdev_add(l);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(clk_add_alias);

Oh, and a really good thing to do would be to fix the error checking and
returning in there (why did I miss it in the original PXA version...)
