From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/7] OMAP4: Patch series
Date: Tue, 21 Apr 2009 18:43:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A9A6430B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbZDUNNW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 09:13:22 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3LDDFqY000830
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 08:13:21 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3LDDEdo017098
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 18:43:14 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Following is the patch series to enable basic board support for OMAP4430. The patches are generated against mainline version 2.6.30 -rc2. The kernel is validated on the OMAP4430 software simulator platform.

The series contains:
-	[PATCH 1/7][RFC] OMAP4: Create architecture macros and config entries.
-	[PATCH 2/7][RFC] OMAP4: Create board support for OMAP_4430SDP.
-	[PATCH 3/7][RFC] OMAP4: Update common omap platform headers.
-	[PATCH 4/7][RFC] OMAP4: Update common omap platform common sources.
-	[PATCH 5/7][RFC] OMAP4: Update common omap machine specific sources.
-	[PATCH 6/7][RFC] OMAP4: Clock hack since clock management framework not in.
-	[PATCH 7/7][RFC] OMAP4: Enable basic build support.

Regards,
Santosh