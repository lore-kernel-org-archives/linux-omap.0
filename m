From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: 3.5-rc3: vdd_mpu_iva warnings
Date: Mon, 18 Jun 2012 11:39:57 +0100
Message-ID: <WC20120618103957.6103F2@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:55530 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752195Ab2FRKkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 06:40:09 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q5IAe1V9011945
	for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 11:40:06 +0100
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.6)
	with ESMTP id md50002237718.msg
	for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 11:40:01 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I have a GUMSTIX Overo AirSTORM module (AM3703-based).

When booting the kernel the following features are listed:
OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )

After booting I get the following (repeating every few seconds):

[   81.122558] voltdm_scale: No voltage scale API registered for vdd_mpu_iva
[   81.130340] platform mpu.0: omap_target: unable to scale voltage up.

I have SmartReflex enabled, and the same defconfig used to work on 3.4.
CONFIG_OMAP_SMARTREFLEX=y
CONFIG_OMAP_SMARTREFLEX_CLASS3=y

I'm assuming this is because of changes to twl-common.c to add the "IVA" voltage 
domain, but on the OMAP I have there is no IVA - hence the warnings?

Is there a known fix for this (disabling SmartReflex seems to make no difference)?

Cheers,
Joe Woodward


