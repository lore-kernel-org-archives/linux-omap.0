From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/07] OMAP3: SR: Fixes in Smartreflex driver
Date: Fri, 20 Mar 2009 18:01:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EEED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58327 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbZCTMbP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 08:31:15 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KCV6vu011196
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 07:31:12 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KCV4qt022965
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:01:05 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

Hi,

This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now
functional and is validated with these patches on a ES3.1 based SDP with the
N values in Efuse.

Patches apply on top of the pm-2.6.28 branch from Kevin's pm tree.
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 

regards,
Rajendra