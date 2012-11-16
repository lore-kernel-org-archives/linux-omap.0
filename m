From: Igor Mazanov <i.mazanov@gmail.com>
Subject: USB only powered Beaglebone powers off when ethernet cable is connected
Date: Fri, 16 Nov 2012 18:34:43 +0400
Message-ID: <k85isq$cv0$1@ger.gmane.org>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35826 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab2KPOeW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 09:34:22 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TZN00-0006L2-SZ
	for linux-omap@vger.kernel.org; Fri, 16 Nov 2012 15:34:28 +0100
Received: from 77.232.56.122 ([77.232.56.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 15:34:28 +0100
Received: from i.mazanov by 77.232.56.122 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 15:34:28 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Interesting, but Beaglebone powers off on the boot in case when the board is 
powered only via USB and ethernet cable is connected. It looks like PMIC turns 
off all voltages on the board - even Power LED doesn't light and USB device 
disappears from the host. The described situation doesn't show with an external 
PSU or without ethernet cable.

I don't think that is a hardware problem because the board boots fine with a 
kernel/userland config from original supplied TF card.

I use the current git kernel with DTS and omap2plus_defconfig.

Regards,
Igor.

