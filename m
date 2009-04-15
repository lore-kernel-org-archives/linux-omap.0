From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/10] OMAP3: SR: Fixes in Smartreflex driver
Date: Wed, 15 Apr 2009 18:25:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59052 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbZDOMzO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 08:55:14 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3FCt7qE017280
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 07:55:13 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3FCt6Tv021591
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 18:25:06 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Re-sending this patch-set with some mailer issues resolved. They now apply cleanly
with a git-am/git-apply.

Hi,

This series fixes a set of defects/issues in Smartreflex driver. SR autocompensation is now
functional and is validated with these patches on a ES3.1 based SDP with the N values in Efuse.

The patches also make the Smartreflex driver independent of SRF by using the OMAP PM apis
instead of calls to SRF.

Patches apply on top of the latest pm branch from Kevin's pm tree.
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 

regards,
Rajendra
