From: Abhishek Karan <a.k.living.on.instinct@gmail.com>
Subject: Remounting of system partition
Date: Fri, 28 Jun 2013 07:13:26 +0000 (UTC)
Message-ID: <loom.20130628T090949-560@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60172 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab3F1HPG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jun 2013 03:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1UsSta-0007G3-QS
	for linux-omap@vger.kernel.org; Fri, 28 Jun 2013 09:15:03 +0200
Received: from 59.145.174.34 ([59.145.174.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 28 Jun 2013 09:15:02 +0200
Received: from a.k.living.on.instinct by 59.145.174.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 28 Jun 2013 09:15:02 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am facing one problem in one of the OMAP4430 based tab that I am using.
I try to remount the system partition as rw but it is not doing so .
as some other service is continuously remouting it to ro.
I am getting the following logs a lot of time

<6>[  645.504150] C1 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  645.534545] C1 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  650.121795] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  650.147888] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  654.732482] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  654.758270] C1 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  660.346282] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  660.370635] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  662.031921] C1 [       watchdog] !@Sync 13

<6>[  664.957794] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  664.983764] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  670.567962] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  670.594787] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  674.640686] C0 [    kworker/0:1] max17042 7-0036: VCELL : 3784, 
data : 0xbd38

<6>[  674.641479] C0 [    kworker/0:1] max17042 7-0036: AVG Current : 449, 
data :0xb3a

<6>[  674.642242] C0 [    kworker/0:1] max17042 7-0036: Current : 456, 
data :0xb68

<6>[  674.642974] C0 [    kworker/0:1] max17042 7-0036: SOC : 18, data : 
0x1252

<6>[  674.645233] C0 [    kworker/0:1] max17042 7-0036: TEMPERATURE : 278, 
data :0x1bdf

<6>[  674.705383] C0 [    kworker/0:1] battery_manager battery_manager: 
vcell = 3784000 soc = 18  current = 456 avg_current = 449 status = 2 
health = 1 temp = 278 discharge status = 0, limit time : 0, bootmode : 0

<6>[  675.183227] C1 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  675.210021] C1 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  679.795349] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  679.821105] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  685.408721] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  685.436767] C0 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

<6>[  690.026428] C1 [          mount] EXT4-fs (mmcblk0p9): re-mounted. 
Opts: (null)

Can you help me with it that whether it is a bug or is it normal 
for the partition to be remounted so many times

thanks and Regards

