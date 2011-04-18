From: Mario Demontis <mario.demontis@ecothermo.it>
Subject: OMAP3530 serial hang
Date: Mon, 18 Apr 2011 12:47:59 +0000 (UTC)
Message-ID: <loom.20110418T143515-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37912 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab1DRMuK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 08:50:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1QBnu5-0006BY-5p
	for linux-omap@vger.kernel.org; Mon, 18 Apr 2011 14:50:09 +0200
Received: from 87.241.57.106 ([87.241.57.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 14:50:09 +0200
Received: from mario.demontis by 87.241.57.106 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 14:50:09 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello
I'm using Embest Devkit8000 with 2.6.37 kernel and I'm experiencing issues with 
serial port.
I have a modem (gprs8000) attached to /dev/ttyO0 and during operation it 
randomly freezes (sometimes I have to wait long time, say, about 1-2 hours). 
After the freeze I cannot use that port anymore (unless I reboot), even if 
I remove the modem: microcom gets stuck and I have to kill -9 it, 
so I presume the driver is hung.

Could you please help me with this issue?

Thanks and regards
Mario

