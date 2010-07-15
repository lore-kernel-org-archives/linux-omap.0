From: Han Wang <hw342@cornell.edu>
Subject: Power managment on Overo
Date: Thu, 15 Jul 2010 05:00:11 +0000 (UTC)
Message-ID: <loom.20100715T065056-117@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48930 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267Ab0GOFFG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jul 2010 01:05:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1OZGd5-0002Pg-Ux
	for linux-omap@vger.kernel.org; Thu, 15 Jul 2010 07:05:04 +0200
Received: from cpe-24-59-188-255.twcny.res.rr.com ([24.59.188.255])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 15 Jul 2010 07:05:03 +0200
Received: from hw342 by cpe-24-59-188-255.twcny.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 15 Jul 2010 07:05:03 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, All, 

   I am running the linux-pm-kernel v2.35.rc3 on Overo Earth. I have managed to
suspend the system using "echo mem > /sys/power/state" with "enable_off_mode" 
and "sleep_while_idle" enabled. Currently, I am able to achieve 200mW in suspend 
mode. However, I am seen in other posts, such as this  one  (http://old.nabble.com/
Overo-boot-time--power-management-ts28402656.html#a28463135), that 
people are able to achieve a much lower power signature.
  
   I am particularly interested to know what mode has the SDRAM on Overo  been set to 
during suspend mode? Is it auto-refresh or self-refresh? And whether the TPS/TWL 
power management chip is set to low power mode during suspend mode by the pm
kernel, if not, how to set it?

Thanks,
Han

