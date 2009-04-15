From: "Premi, Sanjeev" <premi@ti.com>
Subject: Supporting multiple PMICs
Date: Wed, 15 Apr 2009 15:08:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC987192@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59589 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbZDOJjI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 05:39:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3F9d197027715
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 04:39:07 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3F9d0rX014908
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 15:09:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,
 
I wanted to hear your views on supporting multiple
power management chips on OMAP3 - beyond TWL4030/TPS65950.
 
There is also a possibility of using TWL4030 being used
in conjuction with other processors as well.
 
Some patches for TPS6535x have earlier been submitted for
TPS6535x and there is ongoing development for TPS65023.
 
Suggestions:
1) Move the PMIC related code for TWL4030 to
   drivers/power/twl4030.c,h
   It will also help in reducing code duplication in the
   board specific files.
   (we already have twl4030_bc_battery.c in this dir)

2) board*.c files should do only the initialization specific
   to the PMIC connections in the board.

3) On same lines, move the specific peripherals - keypad,
   usb, ...
   (This will not be concern for other PMICs that are
   not as feature rich).
   However, it will allow better code sharing between
   PMICs with same/ similar functionality.
 
Still open questions:
1) Where does the generic initialization for the PMIC
   happen?

Best regards,
Sanjeev
