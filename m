From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 11:30:50 +0200
Message-ID: <1268299850.28571.92.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
	 <1268297945.28571.81.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B51@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:27922 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab0CKJbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 04:31:09 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DD32B51@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> [Hiremath, Vaibhav] Tomi,
> 
> Also, there are few patches which still are not merged to main-line, like
> 
> commit 98d31bf6566be9e716f6dfdce8eb39d1c1097b7c
> Author: Vaibhav Hiremath <hvaibhav@ti.com>
> Date:   Wed Jan 13 17:17:10 2010 +0530
> 
>     OMAP: AM3517: Enable DSS2 for AM3517EVM board
> 
>     Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>     [tomi.valkeinen@nokia.com: removed the board file changes]
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 
> commit bb8a88ac57564e2e7ccc813be1d74c45bb467549
> Author: Vaibhav Hiremath <hvaibhav@ti.com>
> Date:   Mon Jan 4 15:34:16 2010 +0100
> 
>     OMAP: Enable DSS2 for OMAP3EVM board
> 
>     Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>     [tomi.valkeinen@nokia.com: removed the board file changes]
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 
> 
> Any specific reason why are holding this back?

Board file patches go through linux-omap. Those patches seem to be in
linux-omap/master, so I guess they'll go through at some point soon.

 Tomi


