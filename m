From: Frank Agius <ftagius@yahoo.com>
Subject: Interaction between USB phy power and MADC driver
Date: Thu, 06 Sep 2012 14:57:42 -0400
Message-ID: <k2ark9$tdn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52269 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933001Ab2IFS4X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 14:56:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1T9hFW-00005z-Nq
	for linux-omap@vger.kernel.org; Thu, 06 Sep 2012 20:56:22 +0200
Received: from static-50-52-145-66.lkvl.mn.frontiernet.net ([50.52.145.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 20:56:22 +0200
Received: from ftagius by static-50-52-145-66.lkvl.mn.frontiernet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 20:56:22 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm seeing what I think is an unintended consequence of powering down 
the USB phy.  All the relavent code is in file twl4030_usb.c. My system 
is setup to use the USB in otg mode.  If nothing is connected to the USB 
OTG port, the phy suspension code is called.  In the chain of calls that 
follows, the vusb3v1 regulator is disabled.  However, according to the 
OMAP power management manual, vusb3v1 is used "to bias the analog 
multiplexers on the four MCPC pins between the carkit and the MADC". 
I've seen if there is no bias on this mux, the MADC driver returns 
incorrect counts on these 4 pins that should be in A/D mode.  If I plug 
something into the USB OTG port, the MADC driver returns the expected 
counts.  I also created a debug version of the twl4030-usb driver, with 
the disabling of the vusb3v1 commented out and the MADC returns the 
correct counts regardless of the state of the USB OTG port.

Since the vusb3v1 regulator is required for the proper operation of the 
mux and by extension the MADC and carkit mode, shouldn't it always be 
enabled?

frank

