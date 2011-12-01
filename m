From: venkat <ven.mur.kris@gmail.com>
Subject: ZOOM OMAP 3530 SOM-LV McSPI expansion configuration and testing
Date: Thu, 1 Dec 2011 06:04:29 +0000 (UTC)
Message-ID: <loom.20111201T065923-519@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:52142 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab1LAGKK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Dec 2011 01:10:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RVzqQ-0002yJ-TC
	for linux-omap@vger.kernel.org; Thu, 01 Dec 2011 07:10:09 +0100
Received: from 122.172.14.159 ([122.172.14.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 07:10:06 +0100
Received: from ven.mur.kris by 122.172.14.159 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 07:10:06 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
    I am using ZOOM OMAP 3530 SOM-LV board. Board successfully bootup and i got
the /dev/spidev3.0 . When i use the test program to send the data on the spi
device, and the wave form in the oscilloscope shows the the data drops after 5
bits.. i.e if i try to send the data 0xff, the first five bits are correct
w.r.to clock and the remaining 3 bits does not show on the oscilloscope ..

I am using the default omap2_mcspi.c 


can you please help what is the problem ...

