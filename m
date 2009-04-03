From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/02] OMAP3 clock: Remove virtual clock nodes
Date: Fri, 3 Apr 2009 21:49:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42697 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935694AbZDCQUJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:20:09 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n33GK1kI008822
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 11:20:07 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n33GK0EQ016395
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 21:50:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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

Patches generated and apply on latest pm branch from Kevin's pm tree.

regards,
Rajendra