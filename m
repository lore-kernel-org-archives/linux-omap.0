From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/09] OMAP3 clock: Clock rate change notifiers
Date: Fri, 20 Mar 2009 18:55:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF1D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39606 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbZCTNZl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:25:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDPWhg010686
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:25:39 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDPUcL002907
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:55:31 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

Hi,

This patch set reverts some patches from Paul Walmsley to add the clock
notification infrastucture for OMAP3, and adds new patches from him on top, which
have only been circulating internally.
These patches are posted as they are needed for the patch set to remove virtual
clock nodes that will follow.

These patches are based on the pm-2.6.28 branch from Kevin's pm tree.

regards,
Rajendra
