From: Tony Abad <antoniomabad@gmail.com>
Subject: Re: OMAP watchdog broken on 37XX?
Date: Thu, 16 Feb 2012 15:48:26 +0000 (UTC)
Message-ID: <loom.20120216T163912-59@post.gmane.org>
References: <BANLkTi=WQzdfOXqYWGe8gFjrn=kHbg-2eQ@mail.gmail.com> <BANLkTi=F0wzMXUOUFJ2y9CeRkYckMDyaVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47436 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab2BPQAF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 11:00:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Ry3ka-0006DU-5a
	for linux-omap@vger.kernel.org; Thu, 16 Feb 2012 17:00:04 +0100
Received: from 146-115-190-162.c3-0.wtr-ubr1.sbo-wtr.ma.cable.rcn.com ([146.115.190.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 17:00:04 +0100
Received: from antoniomabad by 146-115-190-162.c3-0.wtr-ubr1.sbo-wtr.ma.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 17:00:04 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

 
> did you try twl4030_wdt instead of omap_wdt?

Hi Enrico,

Last night I went searching around for a fix on the same watchdog problem Steve
was having, but this time on a BeagleBoard XM Rev. C., using the 37xx chip. 
Using the twl4030_wdt driver instead of omap_wdt driver succeeded in rebooting
the system, but with these issues:

1. When running the watchdog from a C program (e.g. using the example code from
http://embeddedfreak.wordpress.com/2010/08/23/howto-use-linux-watchdog/), the
program executable itself has been changed such that its 0 bytes after the 
reboot.

2. It's impossible to get the cause of the last power cycle via the watchdog. 
i.e. The WDIOC_GETBOOTSTATUS is handled differently in twl4030_wdt vs. 
omap_wdt, the latter of which relies on omap_prcm_get_reset_sources().

So while the twl4030_wdt driver gets me 90% there, I still need the ability to
detect a watchdog-causes reset vs. any other reset.  So, is there a patch 
coming for the omap_wdt driver for 37xx boards?

Regards,

Tony

