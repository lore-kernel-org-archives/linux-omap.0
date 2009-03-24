From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH 00/08] OMAP3: SR: Fixes in Smartreflex driver - Resending
Date: Tue, 24 Mar 2009 16:22:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAFEE9A9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49842 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728AbZCXKwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 06:52:15 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2OAq7WX010336
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 05:52:13 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2OAq7Ow025818
	for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 16:22:07 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Hi,

Resending the patches sent by Rajendra after fixing Kevin's comments and cleanup.

This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now functional and is validated with these patches on a ES3.1 based SDP with the N values in Efuse.

Patches apply on top of the pm-2.6.28 branch from Kevin's pm tree.
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 

regards,
Rajendra--
