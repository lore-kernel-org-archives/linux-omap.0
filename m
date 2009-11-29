From: Peter Barada <peterb@logicpd.com>
Subject: Problems trying to boot am3517 w/NFSroot
Date: Sun, 29 Nov 2009 10:56:12 -0500
Message-ID: <1259510172.4649.33.camel@thunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:45674 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752101AbZK2RHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Nov 2009 12:07:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I'm trying to boot an am3517 using TI's PSP-SDK-03.00.00.02 kernel, and
it fails to get an IP address w/dhcp (retrying forever).  I used the
omap3517_evm_defconfig to config the kernel.

The command line is  "console=ttyS2,115200n8 root=/dev/nfs rw
nfsroot=192.168.3.5:/opt/nfs-exports/ltib-am3517,wsize=1500,rsize=1500
ip=dhcp"

Log looks like:

...
Power Management for TI OMAP3.                                                  
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1         
regulator_init_complete: incomplete constraints, leaving LDO2 on                
regulator_init_complete: incomplete constraints, leaving LDO1 on                
regulator_init_complete: incomplete constraints, leaving VDCDC3 on              
regulator_init_complete: incomplete constraints, leaving VDCDC2 on              
regulator_init_complete: incomplete constraints, leaving VDCDC1 on              
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1:00, id=7c0f1)       
Sending DHCP requests .                                                         
PHY: 1:00 - Link is Up - 100/Full                                               
..... timed out!                                                                
IP-Config: Retrying forever (NFS root)...                                       
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1:00, id=7c0f1)       
Sending DHCP requests .                                                         
PHY: 1:00 - Link is Up - 100/Full                                               
..... timed out!                                                                
IP-Config: Retrying forever (NFS root)...                                       
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1:00, id=7c0f1)       
Sending DHCP requests .                                                         
PHY: 1:00 - Link is Up - 100/Full                                               
..... timed out!                                                                
IP-Config: Retrying forever (NFS root)...                                       
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1:00, id=7c0f1)       
Sending DHCP requests .                                                         
PHY: 1:00 - Link is Up - 100/Full                                               
..... timed out!                                                                


Has anyone successfully booted a am3517 using DHCP and NFSroot?

