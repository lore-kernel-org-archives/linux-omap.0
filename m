From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as
 default
Date: Fri, 12 Sep 2008 23:27:01 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344A4F051@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A5344A4F050@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56289 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYIME1I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 00:27:08 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8D4R3iu018912
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:27:08 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8D4R3G3016837
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:27:03 -0500 (CDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5344A4F050@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>Date: Fri, 12 Sep 2008 22:09:45 -0500
>Subject: [PATCH] BRIDGE: set 0 for phys_mempool_* as default

For this to work, we have observed that you must increase the size of Consistent DMA memory up to 14 MB, this is what we consider to be a safe standard size for bridge to work along with other OMAP components.

You can find this on menuconfig:
	-> Device Drivers                                                                                 
		-> Graphics support
		FB_OMAP_CONSISTENT_DMA_SIZE [=14]

Regards,

- omar
