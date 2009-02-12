From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 0/1] DSPBRIDGE Fix condition statement for Global Flush
Date: Thu, 12 Feb 2009 17:58:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C11FE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41976 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529AbZBLM3U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 07:29:20 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1CCTDj2012467
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 06:29:19 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1CCTCGY023931
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 17:59:13 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,
There was a mistake in conditional statement in the previous patch set 

[PATCH 0/3] DSPBRIDGE DVFS and Off mode support for bridgedriver

This patch fixes that.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


Please let me know your comments.

Thanks & regards
Ramesh Gupta G