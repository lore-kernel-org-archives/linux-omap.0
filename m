From: "Pasam, Vijay" <vpasam@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 12:12:24 -0500
Message-ID: <EBA93F3E4CB46947A4C5275F6308CF3E03435165@dlee15.ent.ti.com>
References: <20080818.180829.145776296.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47664 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbYHRRMh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 13:12:37 -0400
Content-class: urn:content-classes:message
In-reply-to: <20080818.180829.145776296.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, "Woodruff, Richard" <r-woodruff2@ti.com>, felipe.contreras@gmail.com, siarhei.siamashka@nokia.com, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, tony@atomide.com, soni.trilok@gmail.com

Hi Hiroshi,

> Yes, "dspgateway" won't support OMAP3 but if I remember 
> correctly that TWL is already in OMAP2? and also does Camera 
> use the same mechanism of this MMU? This may be benefit or a 
> must, I guess..

I agree. If we are certain that camera driver or some other driver uses
MMU the same way bridge does and the MMU architecture is the same, it
makes sense to make this generic code. My point is that if DSPGateway
doesn't use TWL, it will not benefit from using the Bridge MMU code
which has TWL enabled. 

On the other hand, we have a usecase for mailbox driver being used by
multiple IPC stacks. Hence it makes sense to make this code generic.

Best Regards
Vijay
 

