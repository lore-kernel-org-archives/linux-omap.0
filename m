From: "B, Ravi" <ravibabu@ti.com>
Subject: RE: RFC: PATCH TI81xx fix MUSB software mode setting
Date: Tue, 19 Jun 2012 06:18:27 +0000
Message-ID: <6C6B28D4DC342643927BEAFCE8707BF63E9B104D@DBDE01.ent.ti.com>
References: <464859D4BE03A84686BA47749242C1D03EA93DED@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36889 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab2FSGSe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jun 2012 02:18:34 -0400
In-Reply-To: <464859D4BE03A84686BA47749242C1D03EA93DED@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "andrea.scian@dave.eu" <andrea.scian@dave.eu>


> ----- Original Message -----
> From: Andrea Scian [mailto:rnd4@dave-tech.it]
> Sent: Monday, June 18, 2012 08:25 PM
> To: linux-omap@vger.kernel.org <linux-omap@vger.kernel.org>
> Subject: RFC: PATCH TI81xx fix MUSB software mode setting
> 
> 
> Dear all,
> 
> when configuring our platform (DM8148 based) to work with 
> USB0 as device and USB1 as host I've found some problems.

It seems that you created the patch against the ti-psp release, there
is another way to achieve this (one port as host and other port as device). 
Please refer to release/user's guide.
Moreover, you should create a patch against mainline, where the musb_dsps.c is
used instead of ti81xx.c, where there is no host-only or device-only mode, by 
default OTG mode is used.

> It was fine if I configure both as device or both as host or 
> enable only one port, but configure both in different modes 
> lead to a not working configuration.
> After a bit of debug I've found that probably the problem is inside
> ti81xx_musb_set_mode() because this configure the controller 
> but does not set musb->board_mode. IIUC, without setting this 
> structure the whole musb generic state machine does not work 
> correctly.
> Attached you can find the patch that fixed the problem on our 
> board. I hope -this can help others too and can be integrated 
> inside the main tree.
> Feel free to comment and tell me if I've done something wrong.
> 
> I hope the the patch format is quite correct for you.
> 
> Best Regards,
> 
> 
> -- 
> 
> Andrea SCIAN
> 