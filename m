From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 0/1] Export clock notifier symbols to kernel modules
Date: Thu, 12 Feb 2009 06:52:12 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C0BED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47002 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbZBLBWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 20:22:51 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C1Mi1Q030376
	for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2009 19:22:50 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C1MgUN005059
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 06:52:42 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi All,
This is to export clk_notifier_register and clk_notifier_unregister
Symbols for building kernel module. This can be applied on pm branch.


Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
arch/arm/plat-omap/clock.c |    2 ++
1 files changed, 2 insertions(+), 0 deletions(-)


Please let me know your comments.

Thanks & regards
Ramesh Gupta G
