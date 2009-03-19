From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 3/7] ARM: OMAP: Add command line option for I2C bus
 speed
Date: Thu, 19 Mar 2009 13:22:20 +0200
Message-ID: <20090319132220.bffc5cee.jarkko.nikula@nokia.com>
References: <20090304214540.21101.72079.stgit@localhost>
	<20090304215105.21101.88365.stgit@localhost>
	<20090305162043.GY6784@atomide.com>
	<20090306091304.7d2d8ecd.jarkko.nikula@nokia.com>
	<20090306161349.GC32353@atomide.com>
	<20090318193045.GD30132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62555 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbZCSLWW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 07:22:22 -0400
In-Reply-To: <20090318193045.GD30132@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 18 Mar 2009 20:30:45 +0100
ext Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > > I had similar thought as Felipe that it looks more generic this
> > > way. But don't know now immediately would multibuild will work?
> > > Was that your concern? E.g.
> > > 
> > > __setup("i2c_bus=", arm_xxx_i2c_bus_setup);
> > > __setup("i2c_bus=", omap_i2c_bus_setup);
> > 
> > Well is it generic enough to work for everybody? And if so, we
> > should run it by the LKML and the linux-i2c lists.
> 
> Any comments from the I2C list?
>
Unfortunately not. Are there some conference or why the list have been
so idle recently?

http://marc.info/?l=linux-i2c&r=1&b=200903&w=2


Jarkko
