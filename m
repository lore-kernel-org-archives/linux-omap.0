From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH V2] misc : ROHM BH1780GLI Ambient light sensor Driver
Date: Tue, 1 Jun 2010 22:27:15 +0200
Message-ID: <20100601202715.GV2695@buzzloop.caiaq.de>
References: <39216.10.24.255.17.1274699065.squirrel@dbdmail.itg.ti.com>
 <20100601131244.7164b43c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:41824 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505Ab0FAU1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 16:27:20 -0400
Content-Disposition: inline
In-Reply-To: <20100601131244.7164b43c.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hemanth V <hemanthv@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, Wolfram Sang <w.sang@pengutronix.de>

On Tue, Jun 01, 2010 at 01:12:44PM -0700, Andrew Morton wrote:
> On Mon, 24 May 2010 16:34:25 +0530 (IST)
> "Hemanth V" <hemanthv@ti.com> wrote:
> 
> > This patch adds support for ROHM BH1780GLI Ambient light sensor.
> > 
> > BH1780 supports I2C interface. Driver supports read/update of power state and
> > read of lux value (through SYSFS). Writing value 3 to power_state enables the
> > sensor and current lux value could be read.
> 
> There are at least two other ambient light sensor drivers:
> drivers/misc/isl29003.c and drivers/misc/tsl2550.c.
> 
> Is there any standardisation of the ABIs whcih these drivers offer?  If
> so, does this new driver comply with that?

Jonathan proposed the ALS framework for these type of devices, but it
was rejected (don't know about the reasons, I didn't follow the
discussions). The new idea is to put such drivers in the industrial IO
subsystem, but I don't know how mature that approach is currently.

For the time being, these drivers cook up whatever sysfs interface they
like, and their userspace ABIs are not standardized, unfortunately.

> It would be most useful if the changelog were to fully describe the
> proposed kernel<->userspace interface.  That's the most important part
> of the driver, because it's the only part we can never change.
>
> There is a desultory effort to maintain sysfs API descriptions under
> Documentation/ABI/.  I'd have thought that it would be appropriate to
> document this driver's ABI in there.

FWIW, I put some documentation about the isl29003 to
Documentation/misc-devices when I wrote the driver.

Daniel

