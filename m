From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
	uBoot)?
Date: Mon, 16 Jan 2012 10:03:44 +0000
Message-ID: <WC20120116100344.4204CC@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:57462 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751896Ab2APKEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 05:04:10 -0500
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q0GA42MO015125
	for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 10:04:07 GMT
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.2)
	with ESMTP id md50002145344.msg
	for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 10:04:02 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The latest uBoot release (2011.12) disables the L2/outer cache during boot on OMAP boards.
 
uBoot commit: "armv7: disable L2 cache in cleanup_before_linux()" on 6th Dec 2011 by Aneesh V adds the following to 
uBootSources/arch/arm/cpu/armv7/cpu.c:cleanup_before_linux():
  ...
  v7_out_cache_disable();
 
The commit message implies this change was to make booting reliable on OMAP4 by disabling L2 cache before jumping to Linux. Sadly 
this commit also affects OMAP3-based boards...
 
Since switching to uBoot 2011.12 I'm seeing about half the performance on my GUSMTIX Overo (OMAP3530).
 
In the kernel sources there seem to be OMAP4 specific functions for re-enabling the L2 cache (omap4-common.c:omap_l2_cache_init()), 
but none for OMAP3.
 
So my question is... do we expect that Linux should be re-enabling the L2/outer cache during boot after uBoot has disabled it on OMAP3?
 
Cheers,
Joe
 
(See http://lists.denx.de/pipermail/u-boot/2012-January/115056.html for uBoot mailing list on this subject)
 


