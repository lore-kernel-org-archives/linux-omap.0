From: "Talis, Gilles" <g-talis@ti.com>
Subject: OMAP3 Slave McSPI driver
Date: Tue, 9 Feb 2010 10:36:02 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E782241C@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49163 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab0BIJgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 04:36:09 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o199a6AQ028469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 9 Feb 2010 03:36:06 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o199a6bj007365
	for <linux-omap@vger.kernel.org>; Tue, 9 Feb 2010 03:36:06 -0600 (CST)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o199ZsIJ027753
	for <linux-omap@vger.kernel.org>; Tue, 9 Feb 2010 03:36:06 -0600 (CST)
Content-Class: urn:content-classes:message
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

My customer is using Android 2.6.29 kernel from OMAPZOOM and is looking for support for slave mode on the SPI driver.
I saw there were patches for this feature sent to this list, but I was wondering if those patches were tested on 2.6.29.

I am also looking for some kind of API usage guidelines. How to setup the slave mode and how is OMAP notified that data have been received from external master device? My customer plans to use this driver in interrupt mode (no DMA needed).

Thanks
Gilels.



Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920



