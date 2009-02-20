From: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Subject: How to add KGDB support to OMAP uImage
Date: Fri, 20 Feb 2009 16:06:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301C74A69C6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35418 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602AbZBTKge convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 05:36:34 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1KAaRk3012257
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 04:36:33 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1KAaQJT021416
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 16:06:26 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


All,

I'm trying to add KGDB support for OMAP3530 uImage. I did 'make menuconfig' and selected 'kernel object debugging' in 'kernel hacking section' kernel compiled properly but when I tried to boot with this uImage it hanged.

I tried applying KGDBOE patches also. I applied eth, netpoll and core-lite patches. It worked successfully for eth patch but failed at compile time for other two patches.

I want to add KGDB support to the uImage. Is there any different patch to be applied? Has anyone tried this before? Please help me out.

Regards,
Yogesh Marathe.
DSP/BIOS LINK (PSP)
Texas Instruments (India)
+91 80 25048703.
 
