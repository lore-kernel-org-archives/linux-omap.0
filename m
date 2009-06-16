From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 00/04] OMAP3: PM: Optimizations and fixes in sleep/voltage
 scaling
Date: Tue, 16 Jun 2009 17:21:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03059BC545@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55702 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZFPLwF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 07:52:05 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GBq0Dn008938
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 06:52:06 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5GBpxFU016696
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 17:22:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Derrick, David" <dderrick@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

Hi,

This patchset contains a few optimizations and fixes in OFF and Auto voltage scaling path.
Also the 3430sdp specific sleep/wake sequence and device group associations are
fixed in the board file for 3430sdp.

Thanks to David Derrick and Richard Woodruff @ TI for identifying and recomending most
of these fixes.

regards,
Rajendra