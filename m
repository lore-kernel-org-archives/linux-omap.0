From: Charles Manning <manningc2@actrix.gen.nz>
Subject: No more software ECC in omap2.c NAND driver. Why?
Date: Thu, 18 Nov 2010 14:06:15 +1300
Message-ID: <201011181406.15212.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:36166 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753641Ab0KRBM5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Nov 2010 20:12:57 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Between 2.6.35 and 2.6.36 there have need quite a few changes in the NAND 
driver, including a change from software to hardware ECC.

The new code has hardware ECC forced on by:

#define CONFIG_MTD_NAND_OMAP_HWECC

I am surprised that this was done. Surely this should have been a Kconfig 
option to select either sw ECC or hw ECC?

Does moving to hardware ECC to the exclusion of software ECC reduce 
functionality?

Does the new hwecc scheme still support sub-page writes or does it only 
provide full page writes? If sub-page writes are lost then this has  a ripple 
effect in breaking the way some UBI stuff works.

-- Charles

