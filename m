From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Break: SMSC911x problems on Zoom3
Date: Tue, 15 Dec 2009 03:00:49 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FABD21A8@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0912141353270.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41672 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbZLNVa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 16:30:56 -0500
In-Reply-To: <alpine.DEB.2.00.0912141353270.12561@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>


SMSC911x is preventing Zoom3 board from booting on latest master (06d9e4fdd20e).

Bootup logs and shows getting stuck here:
---
net eth0: SMSC911x/921x identified at 0xd080c000, IRQ: 318
mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 STM16G 1.00 GiB
 mmcblk1: unknown partition table
Sending DHCP requests ...... timed out!
IP-Config: Retrying forever (NFS root)...
net eth0: SMSC911x/921x identified at 0xd080c000, IRQ: 318
Sending DHCP requests ...

