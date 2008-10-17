From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 01/04] OMAP3 SRF: Generic shared resource f/w
Date: Fri, 17 Oct 2008 17:01:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B038EC85@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B038E9DC@dbde02.ent.ti.com>
 <02bd01c9302c$1e630570$LocalHost@wipultra1382>
 <B85A65D85D7EB246BE421B3FB0FBB59301B038EC1A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbYJQLcI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 07:32:08 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9HBW0Vf006194
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 06:32:06 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B038EC1A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

And finally, you had proposed to move to mutex instead of spin locks. Are you sure that we would do a resource_request or request_release from an interrupt context? If unsure maybe we can keep using spin locks and move to using GFP_ATOMIC. You may decide.

