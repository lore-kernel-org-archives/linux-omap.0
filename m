From: "Mahaveer, Vishal" <vishalm@ti.com>
Subject: RE: [PATCH 1/1] OMAP: TWL: set clk32kg regulator on
Date: Mon, 7 Nov 2011 21:03:06 +0000
Message-ID: <59CD7F2B651AD44A9EFE2AFA6166395D0845AA@DFLE34.ent.ti.com>
References: <1320162052-32276-1-git-send-email-vishalm@ti.com>
	<1320162052-32276-2-git-send-email-vishalm@ti.com>	<87zkgb1nta.fsf@ti.com>
	<59CD7F2B651AD44A9EFE2AFA6166395D083879@DFLE34.ent.ti.com>
 <871utju42t.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54426 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab1KGVDI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 16:03:08 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pA7L37LI018150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Nov 2011 15:03:07 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pA7L37Sf008680
	for <linux-omap@vger.kernel.org>; Mon, 7 Nov 2011 15:03:07 -0600 (CST)
In-Reply-To: <871utju42t.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hilman, Kevin wrote:
> 
> No.
> 
> You want it on only
> 
> 1) if the connectivity chip is present, *and*
> 2) BT, WLAN, FM or GPS are being used.
> 
> The current patch assumes that a connectivity chip is present
> whenever the TWL is present, which may be true on the platform you're
> currently working on, but is not true in general.  
> 
> And, even if it were present, for power reasons the regulator should
> be enabled only when it's needed, not because it might be needed. 
> That means that the device-specific (or board specific) code should
> be configuring the regulators used for the various modules so the
> drivers can request the regulators when they're needed.    
> 
> Kevin

Will it make more sense to move clk32 regulator initialization to board-xxx files of platforms which has the connectivity chip?

- Vishal