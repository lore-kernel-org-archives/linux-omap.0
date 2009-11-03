From: Tony Lindgren <tony@atomide.com>
Subject: Re: Driver Merge Questions
Date: Tue, 3 Nov 2009 08:58:21 -0800
Message-ID: <20091103165821.GG8981@atomide.com>
References: <4AF040D1.7020109@kionix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59483 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbZKCQ6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 11:58:20 -0500
Content-Disposition: inline
In-Reply-To: <4AF040D1.7020109@kionix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Chris Hudson <chudson@kionix.com> [091103 06:48]:
> Hello all,
> 
> I've never submitted any software to Linux before, but I've been
> working on some new accelerometer drivers that should be ready for
> review soon (pending company approval).  I've read lots of
> documentation on patch and driver submissions, but I still have some
> questions that I was hoping someone could help me find the answers
> to.
> 
> 1- My drivers use i2c for hardware communications, miscdevice for
> IOCTLs, and input_dev for data and interrupt status outputs.  Most
> of the other accelerometer drivers that I've looked at use similar
> designs and are located in drivers/hwmon, but I just wanted to
> confirm that this is the correct location currently.

Sounds correct.
 
> 2- I have done all of my hardware testing with OMAP development
> platforms, so I thought it would be best to send my patch
> submissions to this list for review.  The hardware monitoring tree
> is listed in MAINTAINERS as an orphan, but I was planning on
> including lm-sensors@lm-sensors.org as well.  If either of these
> assumptions is incorrect, please let me know.

Yes, please send the patches to both. Also, please run the patches
through scripts/checkpatch.pl --strict, and read the files under
Documentation/Submit* ;)
 
> 3- Should my patch set consist of source, header, kconfig, and
> makefile patches, or should I include my custom changes to mux.c,
> mux.h, and board-zoom2.c as well?  The former are necessary for
> adding driver support, but the latter are specific for my hardware
> testing platform (which others may want to duplicate for testing
> purposes).  I noticed that recent versions of board-zoom2.c are nice
> and clean, so it's probably not a good idea to wedge
> infrequently-used code in there with a bunch of #ifdefs.  I just
> want to get an idea of what is generally included with a new driver.

Compile should work throughout the series for each patch to keep
git bisect working. To me it sounds like one patch for the driver,
and then one to enable the driver in some hardware.

Please not that we're reworking the mux code for omap3 to make it
easier to use. So please make the mux changes yet another patch.
 
> Any help or advice would be greatly appreciated.

Hope this helps!

Regards,

Tony
