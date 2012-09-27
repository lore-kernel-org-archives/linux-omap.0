From: "Singla, Vikas" <vikassingla@ti.com>
Subject: McSPI : MTD framework Issue
Date: Thu, 27 Sep 2012 13:36:49 +0000
Message-ID: <E4A00299C1DD664AADA8ADB84486F36BB9B17C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48119 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747Ab2I0Ngx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 09:36:53 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q8RDapFI026620
	for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 08:36:52 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q8RDapoh003018
	for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 19:06:51 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Loading "omap2_mcspi.ko" and "m25p80.ko" modules.
Trying to remove SPI module(omap2_mcspi.ko) during the I/O of SPI.
The module should not be removed since it is still in use. 
But when run this test, bunch of kernel errors occurs. 
'lsmod' doesn't show the spi module anymore,
but flash module(m25p80.ko) is still loaded there.

So, trying to create dependencies in SPI Framework and MTD Framework.
Is this problem seen elsewhere, as I am using Linux 2.6.37+ Image.
