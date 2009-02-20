From: "Premi, Sanjeev" <premi@ti.com>
Subject: OMAP3: PM : Timer to turn LCD off
Date: Fri, 20 Feb 2009 18:54:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301C74A6B3D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41080 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbZBTNY6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 08:24:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1KDOnjZ017326
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 07:24:54 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1KDOmVp028746
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 18:54:48 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

While testing cpuidle (from Kevin's PM beanch) with default configuration for OMAP3EVM, the c-state never transitions from C0.

Even compiling with minimal drivers did not help. "fck_core1" continues to be active.
Also, the LCD continues to be powered on... Despite compiling out V4L and FB drivers.

A simple way to turn LCD off would be to implement an inactivity timer. (e.g. serial.c on the pm branch)

The question is - where should this timer be implemented?
- As part of the backlight driver?
  OR
- As part of the fb driver?
  OR
- Should it be tied to the board initialization?

Best regards,
Sanjeev
