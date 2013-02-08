From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP baseline test results for v3.8-rc6
Date: Fri, 8 Feb 2013 18:32:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081830310.28008@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com> <20130207083217.GA15462@arwen.pp.htv.fi> <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com> <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com> <alpine.DEB.2.00.1302081332200.11464@utopia.booyaka.com>
  <79CD15C6BA57404B839C016229A409A83EC071DC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50786 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946746Ab3BHScZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 13:32:25 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC071DC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


By the way, here's what I used for v3.7-rc8, which seemed to work okay:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc8/20121204220128/build/am33xx_only/

and here's the boot log:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc8/20121204220128/boot/am335xbone/am335xbone_log.txt

Note of course that there are some Kconfig changes between v3.7-rc8 and 
v3.8-rcX, so it's possible that the problem could be in those changes, of 
course.


- Paul
