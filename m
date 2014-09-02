From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 3/6] ARM: dts: am437x-gp-evm: Don't use read/write wait
 monitoring
Date: Wed, 03 Sep 2014 00:32:17 +0530
Message-ID: <54061439.1030909@pek-sem.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <1409666227-20622-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([162.210.70.55]:51367 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751850AbaIBTC2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 15:02:28 -0400
In-Reply-To: <1409666227-20622-4-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Hi Roger,


On Tuesday 02 September 2014 07:27 PM, Roger Quadros wrote:
> NAND uses wait pin only to indicate device readiness after
> a block/page operation. It is not use to extend individual
> read/write cycle and so read/write wait pin monitoring must
> be disabled for NAND.
>
I think this is incorrect assumption. NAND framework allows
wait-pin monitoring at end of each read/write cycle. Please
refer following code in drivers/mtd/nand/nand_base.c
	@@ void nand_wait_ready(...)

- nand_wait_ready() calls controller-driver specific call-back
   for chip->dev_ready().

- chip->dev_ready in-case of OMAP NAND drivers is set in
   drivers/mtd/nand/omap2.c  during probe.
	if (pdata->dev_ready) {
		nand_chip->dev_ready = omap_dev_ready;
		nand_chip->chip_delay = 0;
	}

Problem is we don't set pdata->dev_ready correctly as part
of platform-data dring GPMC initialization. This was what my
earlier patch for wait-pin monitoring about. But it was a
quick fix for NAND devices.

So, I suggest to fix wait-pin monitoring instead of de-scoping
it from DTS as wait-pin monitoring should boast the NAND
performance significantly.
(please see if you can find an old mail thread which had some
good feedbacks from Ezequiel and Javier about wait-pin monitoring).

[...]

> This patch also gets rid of the below warning when NAND is
> accessed for the first time.
>
> omap_l3_noc 44000000.ocp: L3 application error: target 13 mod:1 (unclearable)
>
Can you debug this further.
This warning probably comes when driver tries to access some
"reserved" addresses. Or violate read/write bits.


with regards, pekon

------------------------
Powered by BigRock.com

