From: archit taneja <archit@ti.com>
Subject: [Query]Using vcxio regulator on 4430sdp
Date: Wed, 2 Feb 2011 17:00:13 +0530
Message-ID: <4D494045.1020901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41052 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab1BBGAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 01:00:03 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p125xwhp031257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 2 Feb 2011 00:00:00 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p125xvSV014789
	for <linux-omap@vger.kernel.org>; Wed, 2 Feb 2011 11:29:57 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

VCXIO regulator on 4430sdp has consumers like MPU, IVA, and DSI in DSS. 
It is enabled at bootloader itself since its required very early. 
Currently, the regulator_init_data struct for vcxio in board-4430sdp.c 
doesn't show any consumers.

How can I implement regulator_enable/disable calls in my driver for a 
consumer of vcxio without disturbing the mpu and iva etc consumers which 
don't use regulator api to enable/disable the regulator at all.

Also, is anyone aware why vcxio is tied to DSI in 4430sdp, would it be 
possible for some other omap4 board to have a different regulator supply 
for DSI?

Thanks,
Archit
