From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/06] OMAP3430 Errata, defect fixes and optimizations
Date: Thu, 28 May 2009 18:13:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03057E76B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58669 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165AbZE1MnI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 08:43:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4SCh4Pl024731
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 07:43:10 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4SCh3Dr009300
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 18:13:03 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This series contains a set of patches which implement new 3430 errata, and some optimizations
and fixes in the SR driver and DVFS path.

These apply on the latest 'pm' branch and are validated on a 3430SDP platform.

regards,
Rajendra