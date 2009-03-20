From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/03] OMAP3 clock: Remove virtual clock nodes
Date: Fri, 20 Mar 2009 19:20:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF37@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47873 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbZCTNuM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:50:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDo3Ub027112
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:50:10 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDo3sQ006727
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 19:20:03 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

Hi,

This patch set removes the virtual clock node implementation for
VDD1/2 on omap3 which was causing issues with recursive locking of spinlocks.
All references to virtual clock nodes from resource framework and cpufreq
driver are removed. Resource framework now uses individual dpll clock
nodes to do frequency scaling.
Most of the functionality implemented as part of the virtual clock nodes
is now implemented internally in the resource framework.

Thanks to Tero Kristo <tero.kristo@nokia.com> who has implemented 
most of these changes.

Patches generated and apply on pm-2.6.28 branch + [PATCH 00/09] OMAP3 clock: Clock rate change notifiers

regards,
Rajendra
