From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7-omap 0/5] mmc-twl4030 loses twl4030-dependency
Date: Wed, 11 Mar 2009 04:18:34 -0800
Message-ID: <200903110518.34945.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:44239 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752020AbZCKMcr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 08:32:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

The last dependency of that code on twl4030 specific behavior
was coupled to regulator usage ... and, hey, there's a regulator
framework to hide such details!

The first four of these patches are from the regulator-next tree:

 - regulator: enumerate voltages
 - regulator: twl4030 voltage enumeration
 - regulator: twl4030 voltage enumeration cleanups
 - MMC: regulator utilities

More precisely ... the first three are, but the wrong version of
the fourth got merged; that should get sorted out soonish.

The last patch does the magic:

 - mmc-twl4030 uses regulator framework

This works if the boards have hooked up their regulators to the
MMC devices.  Beagle does that; so does the 3430 SDP (which has
a second 1.8V SD/MMCplus slot).  I'll resend a patch doing that
for Overo.

So for example two of Adrian's patches from yesterday are now
subsumed by the regulator framework.  To have MMC2 hook up to
an eMMC chip that needs VccQ for interface level shifting, just
hook up the "aux" supply to that MMC device.  To have it use
the VAUX3 supply instead of VMMC2, just be sure to hook up the
right regulator.
