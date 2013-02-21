From: Carl <broszkigroszki@gmail.com>
Subject: ARM:OMAP3:DSS - LCD communication path
Date: Thu, 21 Feb 2013 10:09:42 +0000 (UTC)
Message-ID: <loom.20130221T094755-400@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51181 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137Ab3BUKOq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Feb 2013 05:14:46 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1U8TBB-0005Rc-61
	for linux-omap@vger.kernel.org; Thu, 21 Feb 2013 11:15:05 +0100
Received: from 38.11.static.dcenter.pl ([38.11.static.dcenter.pl])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 21 Feb 2013 11:15:05 +0100
Received: from broszkigroszki by 38.11.static.dcenter.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 21 Feb 2013 11:15:05 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

My colleagues (hardware guys) have made some EMC tests and there is some 
increased emission when there is a static picture on the screen (different
than some animation takes place). They asked me to check if there 
is a possibility to make such test which can help to determine the source of
the problem (lcd display or path between DSS and display - data/clock lines).

Omap DSS is quite new thing for me and I need an information if a simple 
injection of a picture to fb0 device can be some kind of case when traffic on 
data lines (DPI/RGB interface) is only after some data is put into fb0 or 
it is refreshed periodically. I suspect that if DSS hardware on Sitara AM3703
has some data in buffer it manages the vram contests on its own (refreshes 
LCD etc.). 

Regards,
Carl


