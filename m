From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: How do you configure AM335x dts for dual ethernet ?
Date: Thu, 11 Apr 2013 17:14:35 +0100
Message-ID: <5166E16B.6040304@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:41377 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752713Ab3DKQOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Apr 2013 12:14:37 -0400
Received: from [10.0.0.104] (unknown [10.0.0.104])
	by centos1.newflow.co.uk (Postfix) with ESMTP id 0E7F526B8037
	for <linux-omap@vger.kernel.org>; Thu, 11 Apr 2013 17:14:35 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm trying to work out how to setup my custom dts file to support dual ethernet.

This is on a custom board based on the BeagleBone, but with both ethernet ports connected in MII mode.

So far I have just copied the layout of am335x-evm.dts, but that only gives me eth0:-

[    1.418487] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    1.424952] davinci_mdio 4a101000.mdio: detected phy mask fffffffc
[    1.434455] libphy: 4a101000.mdio: probed
[    1.438790] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    1.448486] davinci_mdio 4a101000.mdio: phy[1]: device 4a101000.mdio:01, driver SMSC LAN8710/LAN8720
[    1.458585] Random MACID = 82:72:bb:49:3f:49
[    1.466964] rtc-ds1307 0-0068: setting system clock to 2013-04-11 16:15:37 UTC (1365696937)
[    1.478107] net eth0: initializing cpsw version 1.12 (0)
[    1.486109] net eth0: phy found : id is : 0x7c0f1
[    1.491696] net eth0: phy found : id is : 0x7c0f1

I added:-

mac: ethernet@4a100000 {
	dual_emac = <1>;
};

... which gives me eth0 and eth1, but kills my nfs root:-

[    1.444534] libphy: 4a101000.mdio: probed
[    1.448842] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    1.458422] davinci_mdio 4a101000.mdio: phy[1]: device 4a101000.mdio:01, driver SMSC LAN8710/LAN8720
[    1.468439] Random MACID = 1e:5b:03:c9:a4:f7
[    1.475683] cpsw: Random MACID = 66:56:fa:5e:9f:19
[    1.484027] rtc-ds1307 0-0068: setting system clock to 2013-04-11 16:50:32 UTC (1365699032)
[    1.494911] net eth0: initializing cpsw version 1.12 (0)
[    1.503727] net eth0: phy found : id is : 0x7c0f1
[    4.579126] libphy: 4a101000.mdio:00 - Link is Up - 100/Full
[    4.608561] IP-Config: Guessing netmask 255.0.0.0
[    4.613910] IP-Config: Complete:
[    4.617307]      device=eth0, hwaddr=1e:5b:03:c9:a4:f7, ipaddr=10.0.101.111, mask=255.0.0.0, gw=10.0.0.100
[    4.627473]      host=10.0.101.111, domain=, nis-domain=(none)
[    4.633613]      bootserver=255.255.255.255, rootserver=10.0.0.100, rootpath=
[    4.665520] VFS: Mounted root (nfs filesystem) on device 0:12.
[    4.673877] devtmpfs: mounted
[    4.677461] Freeing init memory: 196K
Starting logging: OK
Initializing random number generator... done.
Starting network...
ip: RTNETLINK answers: File exists
ip: RTNETLINK answers: File exists
[    5.449203] net eth1: initializing cpsw version 1.12 (0)
[    5.456180] net eth1: phy found : id is : 0x7c0f1
udhcpc (v1.20.2) started
Sending discover...
Sending discover...
Sending discover...
No lease, failing
Starting dropbear sshd: OK

Welcome to Buildroot
nanobone login: root
Password:
# ps
[   27.729217] nfs: server 10.0.0.100 not responding, still trying

I know this should work (since the svm has dual ethernet), so can anyone give me some pointers ?

Cheers
Mark J.
