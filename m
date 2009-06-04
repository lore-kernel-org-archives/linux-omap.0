From: Gary Thomas <gary@mlbassoc.com>
Subject: DSS porting problems
Date: Thu, 04 Jun 2009 15:22:00 -0600
Message-ID: <4A283AF8.5010301@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:4723 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZFDVWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 17:22:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

I'm porting my platform (3530, very similar to LDP) to your tree.
  http://www.bat.org/~tomba/git/linux-omap-dss.git
Since you have complete support for the 3430SDP, I started with
that board file.  I've added my own display (larger Hitachi
screen that is 800x600).  I've run into a few problems:

* All output to the main frame buffer (/dev/fb0) seems to go to
the very last line of the display.

* The documentation (Documentation/arm/OMAP/DSS) does not seem
to match what's in sysfs.  In particular, there are no "horizontal"
or "vertical" fields in the displayN tree.  This makes the examples
of how to clone, etc, not work.

Any ideas what I should look at?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
