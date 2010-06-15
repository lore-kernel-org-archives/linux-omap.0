From: Mathieu Poirier <mathieu.poirier@canonical.com>
Subject: SDHC card affected by preemption model in 2.6.35
Date: Tue, 15 Jun 2010 08:52:28 -0600
Message-ID: <1276613548.2824.46.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:44428 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906Ab0FOOwR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 10:52:17 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OOXUv-0003BT-6m
	for <linux-omap@vger.kernel.org>; Tue, 15 Jun 2010 15:52:17 +0100
Received: from s0106002369de4dac.cg.shawcable.net ([70.73.24.112] helo=[192.168.1.103])
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mathieu.poirier@canonical.com>)
	id 1OOXUu-0008Mq-Rk
	for linux-omap@vger.kernel.org; Tue, 15 Jun 2010 15:52:17 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

HW: Beagleboard rev. C2 and C4
Processor: OMAP3
Kernel: 2.6.35-rc2
Driver: mmci-omap-hs

I am faced with an SDHC card problem on a beagleboard.  Some cards
cannot be initialized on startup while others work perfectly.  I tracked
the issue down to one single kernel config: PREEMPT_VOLUNTARY.  

When going from PREEMPT_VOLUNTARY to PREEMPT_NONE the problem goes away.

When booting, a failing card (PREEMPT_VOLUNTARY) will output the
following: 
[ 2.283355] mmc0: error -110 whilst initialising SD card

I have also seen transfer errors such as this one: 
[ 105.343780] mmcblk0: error -110 transferring data, sector 798431, nr
26, card status 0xc00 

When working properly (PREEMPT_NONE), you get: 
[   27.026519] mmc0: new high speed SDHC card at address 0007
[   27.075775] mmcblk0: mmc0:0007 SD08G 7.49 GiB 

We seem to have a little timing problem - has anyone seen the same
issue ?  Can driver "mmci-omap-hs" actually work under
PREEMPT_VOLUNTARY ? 

Thanks, Mathieu.




