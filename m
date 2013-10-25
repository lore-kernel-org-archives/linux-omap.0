From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v2 0/5] Assorted OMAP2 NAND clean-ups
Date: Fri, 25 Oct 2013 11:15:57 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2AE2A@DBDE04.ent.ti.com>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab3JYLQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 07:16:26 -0400
In-Reply-To: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
[...]

> Pekon, Brian: Do you think this solution might work for 8-bit and 16-bit
> devices?
> 
I think NAND_BUSWIDTH_AUTO (without GPMC changes) would fail in
following scenarios..

Case-1: configuring gpmc,device-width=1 from DT when using x16 device.
As your NAND driver is using NAND_BUSWIDTH_AUTO, it should
ignore this DT config, and based on ONFI params it should work as x16

Case-2: configuring gpmc,device-width=2 from DT when using x8 device.
As your NAND driver is using NAND_BUSWIDTH_AUTO, it should
ignore this DT config, and based on ONFI params it should work as x8

NAND device may get detected correctly, but try doing write and read
to NAND, and I think, it would fail for Case-2 at-least.. 
Can you please check ?


> I've been going through the GPMC code again, and it looks like some cleaning
> is needed
> there two, but that's a different story!
> 
Actually having NAND_BUSWIDTH_AUTO would require change in GPMC
driver also.. please refer my comments in.. 
http://lists.infradead.org/pipermail/linux-mtd/2013-October/049284.html

reason of failure is given above...


with regards, pekon
