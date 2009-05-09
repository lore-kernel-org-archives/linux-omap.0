From: "Luke-Jr" <luke@dashjr.org>
Subject: N810: latest linux-omap-2.6.git master
Date: Sat, 9 May 2009 17:45:00 -0500
Message-ID: <200905091745.06435.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wsip-70-184-212-11.om.om.cox.net ([70.184.212.11]:48772 "EHLO
	hachi.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbZEIWzQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 May 2009 18:55:16 -0400
Received: from tsuruki.localnet (unknown [IPv6:2002:46bb:1a76:0:20e:a6ff:fec4:4e5d])
	by hachi.dashjr.org (Postfix) with ESMTP id CC9799614A1
	for <linux-omap@vger.kernel.org>; Sat,  9 May 2009 22:45:08 +0000 (UTC)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Having trouble getting "2.6.30-rc4-omap1" to boot my US N810 (running Gentoo).
The initial problem appears to be related to /dev/mmcblk* missing, but I can't 
debug it very far due to the second problem I encountered:
The keys "fghjvbnm" do not appear to work. I added debug info to print when 
the keyboard FIFO is empty, and also when it has a valid mapping, but these 
keys do not appear to be triggering the 'process_keys' function at all.

Any suggestions?

Thanks,

Luke
