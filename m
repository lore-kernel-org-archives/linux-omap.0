From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Fri, 3 Apr 2009 21:38:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47548 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936024AbZDCQIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:08:18 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n33G8AD8013850
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 11:08:16 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n33G88qd014734
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 21:38:09 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now
functional and is validated with these patches on a ES3.1 based SDP with the N values in Efuse.

The patches also make the Smartreflex driver independent of SRF by using the OMAP PM apis
instead of calls to SRF.

Patches apply on top of the latest pm branch from Kevin's pm tree.
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 

regards,
Rajendra