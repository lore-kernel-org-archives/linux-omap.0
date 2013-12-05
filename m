From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 10:13:52 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:38035 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154Ab3LEJNx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Dec 2013 04:13:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Hello,

on OMAP3, the NAND area holding MLO and u-boot need a different ECC scheme 
(hw) than the rootfs (sw)

is there a way to tell the kernel which ECC scheme to use on a 
per-partition basis?

I'd like to be able to update MLO and u-boot from within a booted Linux 
system on the device (I have to resort to u-boot for that where I can 
control the ECC scheme used)

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
