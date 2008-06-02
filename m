From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/3] ARM: OMAP: SmartReflex driver
Date: Mon, 02 Jun 2008 14:29:52 +0300
Message-ID: <1212406192.32058.18.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23577 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbYFBLaS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 07:30:18 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m52BTxL3017938
	for <linux-omap@vger.kernel.org>; Mon, 2 Jun 2008 14:30:16 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "ext-kalle.jokiniemi" <ext-kalle.jokiniemi@nokia.com>

Here is an updated version of the SmartReflex driver.

Patches 1 and 2 are same as before, but patch 3 has some new things:

- Changed the register accessing to use the prm_xxx_mod_reg{_bits}()
  functions.

- Created a Kconfig entry for SmartReflex in "System type->TI OMAP
  Implementations" menu.

Tested on 3430SDP.


Regards,
Kalle Jokiniemi

---
