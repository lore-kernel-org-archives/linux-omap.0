From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [ANNOUNCE] Temporary L-B tree for bridge 2.6.29
Date: Tue, 19 May 2009 23:35:10 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53040B85D7A3@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38278 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbZETEfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 00:35:18 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4K4ZCmu000805
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 23:35:17 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4K4ZCSR005593
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 23:35:12 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n4K4ZCXJ002005
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 23:35:12 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi All,

I have placed the latest set of TI DSP BRIDGE patches based on linux-omap-pm
2.6.29 branch on gitorious; this is just a temporarily tree until it can be
hosted on omapzoom again.

Special thanks to Hiroshi and Ameya, I took the logical set of patches which
was ported long time back[1] along with the new stuff, I reworked what we had
to migrate to this baseline and will be sending those patches to the list
soon.

In the mean time you can clone from:
	git://gitorious.org/ti-dspbridge/linux-bridge.git

Best Regards,

Omar

---
[1] http://marc.info/?l=linux-omap&m=121878286205991&w=2

