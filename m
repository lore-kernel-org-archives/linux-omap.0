From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: GPMC in HWMOD (and a related AM335X issue)
Date: Fri, 10 Feb 2012 15:42:02 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93177E9BE@DBDE01.ent.ti.com>
References: <1328790544-4423-1-git-send-email-afzal@ti.com>
 <4F348634.8040909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59236 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221Ab2BJPmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 10:42:05 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1AFg3p5009625
	for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 09:42:04 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1AFg3mA006415
	for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 21:12:03 +0530 (IST)
In-Reply-To: <4F348634.8040909@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Benoit,

> > HWMOD entries currently does contain GPMC, is it due to the reason that
> > GPMC is not yet adapted to omap_device / omap_hwmod or is there any
> > other reason for not having it in HWMOD (as GPMC not yet a driver?)
> 
> Yes, that's the reason.
> Nobody had the time to update that driver yet to omap_device and thus we 
> did not create the hwmod entry for it.
> And since we do not use the GPMC on OMAP4 boards, we did not have some 
> good way to test any change on this driver.
> 
> Do not hesitate to update that driver and add the DT support if you want:-)

Thank you the reply.

Within the constraints I have, if possible, I will try to add it.

Regards
Afzal
