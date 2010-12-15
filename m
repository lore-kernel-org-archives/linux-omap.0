From: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Subject: twl4030_usb porting advice
Date: Wed, 15 Dec 2010 11:55:24 +0000
Message-ID: <4D08ACAC.8070900@xlogic.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xen-13-178-63-247-83.statnet.pl ([178.63.247.83]:46274 "EHLO
	xlogic.pl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab0LOME7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 07:04:59 -0500
Received: from [10.0.0.250] (81-18-210-75.static.chello.pl [81.18.210.75])
	by xlogic.pl (Postfix) with ESMTPSA id A459EF17D8
	for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 12:56:07 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi!

I'm trying to port the support patches for an OMAP3530 based development 
kit by Technexion.
Technexion provides patches for PSP kernel trees, I need to use a kernel 
with modern IR stack, so I'm developing against linux-omap-2.6.git


I'm mostly done with the initial port, however, I'm stuck with the 
following issue:

[    2.991973] ehci-omap ehci-omap.0: port 2 full speed --> companion
[    2.992034] ehci-omap ehci-omap.0: GetStatus port:2 status 003801 0 
ACK POWER OWNER sig=j CONNECT
[    2.992095] hub 1-0:1.0: port 2 not reset yet, waiting 50ms
[    3.055511] asoc: twl4030-hifi <-> omap-mcbsp-dai.1 mapping ok
[    3.061920] ehci-omap ehci-omap.0: GetStatus port:2 status 003002 0 
ACK POWER OWNER sig=se0 CSC
[    3.061981] hub 1-0:1.0: unable to enumerate USB device on port 2
[    3.068389] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0004


I would gladly welcome any pointers that could help me solve this issue.

Cheers,
Tomasz
