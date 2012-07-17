From: Archit Taneja <a0393947@ti.com>
Subject: build error with linux-next and omap2plus_defconfig
Date: Tue, 17 Jul 2012 14:53:22 +0530
Message-ID: <50052F0A.3030501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab2GQJYg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jul 2012 05:24:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6H9OZCN001549
	for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 04:24:35 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q6H9OYd8008892
	for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 14:54:34 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

The linux-next tree gives this with omap2plus_defconfig:

	...
	...
LD      init/built-in.o
drivers/built-in.o: In function `of_clk_get':
/home/a0393947/source_trees/linux-next/drivers/clk/clkdev.c:42: 
undefined reference to `of_clk_get_from_provider'
make: *** [vmlinux] Error 1

Any suggestions on how to fix this?

Archit
