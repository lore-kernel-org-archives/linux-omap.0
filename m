From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP baseline test results for v3.8-rc6
Date: Fri, 8 Feb 2013 13:13:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com> <20130207083217.GA15462@arwen.pp.htv.fi> <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48858 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab3BHNNS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 08:13:18 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On Fri, 8 Feb 2013, Hiremath, Vaibhav wrote:

> Sorry for not following up on this for long, I have tested v3.8-rc6 
> (with latest u-boot)on both BeageBone platoforms and I have pasted the logs 
> below as well for reference.
> 
> 
> Paul,
> I have used your MLO & u-boot.img images and tried at my end, and as 
> expected it didn't boot for me. I debugged it further and found that your 
> u-boot doesn't enable support for FDT and that's is the reason it fails to 
> boot.

This MLO & u-boot.img is the one that TI originally shipped on the 
BeagleBone that I received, and it worked fine with an appended DTB on 
v3.7-rc8:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc8/20121204220128/boot/am335xbone/am335xbone_log.txt

So what I'd like to know is why it doesn't work with >= v3.8-rc1
with an appended DTB:

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/boot/am335xbone/am335xbone_log.txt

The point is to try to minimize bootloader dependencies.

Haven't had the chance to try Felipe's suggestion yet re fdt_high.

Also, this is using BeagleBone whites here.


- Paul
