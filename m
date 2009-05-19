From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: slap corruption
Date: Mon, 18 May 2009 20:56:08 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60292F45E00@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44020 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbZESB4N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 21:56:13 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4J1u96p021472
	for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 20:56:14 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4J1u9la020950
	for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 20:56:09 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n4J1u9RK009253
	for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 20:56:09 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kargirwar, Pankaj" <p-kargirwar@ti>




Hi everyone,

We have been looking into the Slab Corruption error and we have found the problem occurs after an application has been terminated abnormally, e.g. Using CTL-C or Segmentation Fault or kill.

The issue is observed not only for DMM test cases but for others test cases that don't use DMM.

The problem is reported by 'slab.c' when a slab object which is inactive, it supposed to be filled with POISON_FREE (6b) and has some 00 within the object, this seems to be corrupted.

Slab corruption: size-64 start=c6bc71e0, len=64
<3>Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
<3>Last user: [<bf063464>]Last user: [<bf063464>](MEM_Free+0x9c/0xe0 [bridgedriv
er])(MEM_Free+0x9c/0xe0 [bridgedriver])

<3>010:010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 6b 00 00 00 00 00 00 00 00


it seems it is not being freed correctly, because instead of being filled only with 6b it has 00 maybe other process is overwriting it.

Does anyone have any idea of what can be happening?

Regards,
Fernando.
