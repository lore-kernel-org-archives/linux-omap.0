From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/2][OMAPZOOM] DSPBRIDGE: Change address resources to void
 __iomem *
Date: Tue, 24 Feb 2009 15:49:37 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602877515D9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54045 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760628AbZBXVtr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 16:49:47 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1OLncKQ020617
	for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 15:49:43 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1OLnc7j027731
	for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 15:49:38 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

	This patches do the needed changes to manage the address resources as void __iomem * instead of u32.

Regards,
Fernando
Guzman
Lugo.
