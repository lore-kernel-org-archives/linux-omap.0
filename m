From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/7] ARM: OMAP: Add command line option for I2C bus
	speed
Date: Wed, 18 Mar 2009 19:30:45 +0000
Message-ID: <20090318193045.GD30132@n2100.arm.linux.org.uk>
References: <20090304214540.21101.72079.stgit@localhost> <20090304215105.21101.88365.stgit@localhost> <20090305162043.GY6784@atomide.com> <20090306091304.7d2d8ecd.jarkko.nikula@nokia.com> <20090306161349.GC32353@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40161 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbZCRTcb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 15:32:31 -0400
Content-Disposition: inline
In-Reply-To: <20090306161349.GC32353@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 06, 2009 at 08:13:50AM -0800, Tony Lindgren wrote:
> * Jarkko Nikula <jarkko.nikula@nokia.com> [090305 23:12]:
> > On Thu, 5 Mar 2009 17:20:43 +0100
> > ext Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > Jarkko, this should also be in Documentation/kernel-parameters.txt.
> > > Can you please reply with a patch for that, and I'll fold it into this
> > > patch?
> > > 
> > Ah, good, will do it over weekend - early next week. Probably better to
> > handle as a separate patch for easier merging with
> > kernel-parameters.txt?
> 
> I think they should get merged as a single patch.
>  
> > > Also, maybe it should be called omap_i2c_bus instead of i2c_bus?
> > > 
> > I had similar thought as Felipe that it looks more generic this way.
> > But don't know now immediately would multibuild will work? Was that
> > your concern? E.g.
> > 
> > __setup("i2c_bus=", arm_xxx_i2c_bus_setup);
> > __setup("i2c_bus=", omap_i2c_bus_setup);
> 
> Well is it generic enough to work for everybody? And if so, we should
> run it by the LKML and the linux-i2c lists.

Any comments from the I2C list?
