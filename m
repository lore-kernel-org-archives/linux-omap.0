From: "Premi, Sanjeev" <premi@ti.com>
Subject: cpuidle and NO_HZ
Date: Thu, 22 Jan 2009 20:14:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301C6DD0347@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39225 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbZAVOog convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 09:44:36 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0MEiTWA003528
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 08:44:35 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0MEiS1F019225
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 20:14:28 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,
 
While trying to use NFS hosted filesystem, I have made a strange observation. Have verified it on multiple OMAP3EVM boards.

With CONFIG_NO_HZ and CONFIG_CPU_IDLE, after the print "Freeing init memory: 152K" in the log below; the boot sequence almost stops for approx a minute before proceeding further.
 
   Sending DHCP requests .<6>eth0: link up, 100Mbps, full-duplex, lpa 0x01E1
   ., OK
   IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.1.9
   IP-Config: Complete:
     device=eth0, addr=192.168.1.9, mask=255.255.255.0, gw=192.168.1.9,
     host=192.168.1.9, domain=india.ti.com, nis-domain=(none),
     bootserver=0.0.0.0, rootserver=192.168.1.2, rootpath=
   Looking up port of RPC 100003/2 on 192.168.1.2
   Looking up port of RPC 100005/1 on 192.168.1.2
   VFS: Mounted root (nfs filesystem).
   Freeing init memory: 152K
   init started: BusyBox v1.11.1 (2008-08-06 21:12:30 IST)
   starting pid 442, tty '': '/etc/init.d/rcS'
 
Later, the system response is slow.
 
Toggling either of these CONFIG options seems to resolve the issue.
 
My initial suspicion was on the SMC911x driver, but during this 'wait' period ping requests to the EVM are successful.

Just wanted to check if anyone has seen this behavior.
(I am on Kevin's latest PM branch 998bd5675a1e...).

Best regards,
Sanjeev
