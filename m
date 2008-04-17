From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
 clock framework
Date: Thu, 17 Apr 2008 10:23:04 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com>
References: <20080416205119.GF17055@atomide.com> <1208441374-25408-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39509 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763225AbYDQQXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 12:23:05 -0400
In-Reply-To: <1208441374-25408-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Hiroshi,

On Thu, 17 Apr 2008, Hiroshi DOYU wrote:

> debugfs can provide the infrastructure to trace the dependencies of
> clock tree hierarchy quite visibly. This patch enables to keep track
> of clock tree hierarchy and expose their attributes under each clock
> directry as below:

As a replacement for print_parents, which was read-only, it seems good to 
me.

But it would be nice to be able to call into clock functions like 
round_rate, set_rate, and set_parent via filesystem writes for debugging 
purposes, and I don't think that debugfs supports this.

I have a patch here that I use for internal testing that builds the clock 
tree in sysfs, and allows for round_rate/set_rate calls, along with 
enable/disable testing.  But sysfs may not be the right place.  It doesn't 
seem like there's any logical place to put it that would not involve major 
upstream arm-wrestling.  Maybe /sys/devices/platform?

There are also procfs and configfs, I suppose.

Obviously, I could continue to carry my debugging patch in my local tree 
here.  But you mention powerdomain links.  I suspect that we will want to 
have a standard place for all of these filesystem entities, particularly 
since one could conceive of a completely userspace power management policy 
that would control powerdomains and clockdomains via the filesystem.  So 
it probably makes sense to discuss this now.

A quick comment on the patch itself, inlined below.

> +static int clk_debugfs_register_one(struct clk *c)
> +{
> +	int err;
> +	struct dentry *d, *child;
> +	struct clk *pa = c->parent;
> +	char s[255];
> +	char *p = s;
> +
> +	p += sprintf(p, "%s", c->name);
> +	if (c->id != 0)
> +		sprintf(p, "%d", c->id);

perhaps separate the ID and the clock name with a colon, if the ID exists?


- Paul
