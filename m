From: "Boswell, Patrick" <Patrick.Boswell@Sypris.com>
Subject: OMAP 3530 without a PMIC
Date: Tue, 22 Feb 2011 15:41:39 -0500
Message-ID: <0E62BBF85AF134469094EB502CE90A321EAC61@TAMPA202EM.se.sypris.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og102.obsmtp.com ([64.18.2.157]:33684 "HELO
	exprod7og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751339Ab1BVUl4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 15:41:56 -0500
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've designed an OMAP3530 board without a PMIC. 

While trying to boot, the kernel cannot locate the rootfs on
/dev/mmcblk0p2. 

The kernel fails to locate the block device when calling
blk_lookup_devt() in genhd.c. 


The twl regulator support must be compiled in to support the MMC reader.
How do I go about
creating an "always on" or "not managed" VMMC so that the device
operates properly?

Thanks.


