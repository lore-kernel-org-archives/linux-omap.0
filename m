From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Strange boot messages on mainline + omap3_defconfig
Date: Fri, 18 Dec 2009 17:46:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AB9D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33588 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbZLRMQQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 07:16:16 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBICGDAL015708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 06:16:15 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBICGCWJ005834
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 17:46:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I get some "mux: Unknown ball ..." messages booting
v2.6.33-rc1 from Linux' tree (built with the omap3_defconfig).

This was on a 3630 SDP.

Won't be looking at this for a while, so just reporting it.

- Anand

0x588
[    0.000000] mux: Unknown ball offset 0x58a
[    0.000000] mux: Unknown ball offset 0x58c
[    0.000000] mux: Unknown ball offset 0x58e
[    0.000000] mux: Unknown ball offset 0x590
[    0.000000] mux: Unknown ball offset 0x578
[    0.000000] mux: Unknown ball offset 0x57a
[    0.000000] mux: Unknown ball offset 0x57c
[    0.000000] mux: Unknown ball offset 0x57e
[    0.000000] mux: Unknown ball offset 0x580
[    0.000000] mux: Unknown ball offset 0x582
[    0.000000] mux: Unknown ball offset 0x584
[    0.000000] mux: Unknown ball offset 0x586
[    0.000000] mux: Unknown ball offset 0x570
[    0.000000] mux: Unknown ball offset 0x572
[    0.000000] mux: Unknown ball offset 0x40
[    0.000000] mux: Unknown ball offset 0x0
[    0.000000] mux: Unknown ball offset 0x2

....
