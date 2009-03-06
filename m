From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 3/7] ARM: OMAP: Add command line option for I2C bus
 speed
Date: Fri, 6 Mar 2009 09:13:04 +0200
Message-ID: <20090306091304.7d2d8ecd.jarkko.nikula@nokia.com>
References: <20090304214540.21101.72079.stgit@localhost>
	<20090304215105.21101.88365.stgit@localhost>
	<20090305162043.GY6784@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47601 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZCFHNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 02:13:08 -0500
In-Reply-To: <20090305162043.GY6784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 5 Mar 2009 17:20:43 +0100
ext Tony Lindgren <tony@atomide.com> wrote:

> Jarkko, this should also be in Documentation/kernel-parameters.txt.
> Can you please reply with a patch for that, and I'll fold it into this
> patch?
> 
Ah, good, will do it over weekend - early next week. Probably better to
handle as a separate patch for easier merging with
kernel-parameters.txt?

> Also, maybe it should be called omap_i2c_bus instead of i2c_bus?
> 
I had similar thought as Felipe that it looks more generic this way.
But don't know now immediately would multibuild will work? Was that
your concern? E.g.

__setup("i2c_bus=", arm_xxx_i2c_bus_setup);
__setup("i2c_bus=", omap_i2c_bus_setup);


Jarkko
