From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/3] ARM: OMAP: SmartReflex driver
Date: Fri, 30 May 2008 17:12:07 +0300
Message-ID: <1212156727.6521.85.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35107 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbYE3OMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 May 2008 10:12:15 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4UEBltJ030022
	for <linux-omap@vger.kernel.org>; Fri, 30 May 2008 17:12:12 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "ext-kalle.jokiniemi" <ext-kalle.jokiniemi@nokia.com>


This patch set integrates smartreflex driver into linux-omap tree.

The first patch adds Texas Instrumets' reference source and header files
for smartreflex driver. Only checkpatch.pl fixes added.

The second patch prepares required register and bit definitions to
enable smartreflex integration.

The last patch integrates the driver into linux-omap. 

Things to do:

- Integration with DVFS, once an implementation is available.

- efuse values should be taken into use instead of precalculated silicon
  characteristics

Regards,
Kalle Jokiniemi

---
