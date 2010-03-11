From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 11:27:38 +0200
Message-ID: <1268299658.28571.89.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
	 <1268297945.28571.81.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B4F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65146 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0CKJ2J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 04:28:09 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DD32B4F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> > Are you sure vdvi is required by the panel? At least the panel in
> > 3430SDP doesn't require it.
> [Hiremath, Vaibhav] As I mentioned before also, we don't need vdvi supply for OMAP3EVM. Infact there is no supply like vdvi coming out of TWL4030
> Since it was being used in panel file I had defined it. But now I can see that we are no longer using vdvi supply, so I can safely remove this supply. Thanks for pointing me to this.
> 
> I have created another patch which will replace the vdvi with vdds_dsi regulator supply; I have tested it on OMAP3EVM.
> 
> Please merge this patch, without this OMAP3EVM DSS/Fbdev will fail in regulator_get.

Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Board file changes will go through Tony. And you should generally send
the patches as inline patches, not attachments.

 Tomi


