From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7] OMAP3: beagle: add support for beagleboard xM
 revision C
Date: Tue, 14 Jun 2011 03:37:08 -0700
Message-ID: <20110614103708.GO3352@atomide.com>
References: <8FFAA0BFC4E5374B8F85F65FE1F2BFA5C62252EF@dlee02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E928C407E@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:41830 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755914Ab1FNKhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 06:37:11 -0400
Content-Disposition: inline
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E928C407E@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kridner, Jason" <jdk@ti.com>
Cc: "Fernandes, Joel A" <joelagnel@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kooi, Koen" <k-kooi@ti.com>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, Jason Kridner <jkridner@beagleboard.org>

* Kridner, Jason <jdk@ti.com> [110607 15:22]:
> > -----Original Message-----
> > From: Fernandes, Joel A
> > Sent: Tuesday, June 07, 2011 4:55 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Kridner, Jason; Kooi, Koen; beagleboard@googlegroups.com
> > Subject: [PATCH v7] OMAP3: beagle: add support for beagleboard xM
> > revision C
> > 
> > OMAP3: beagle: add support for beagleboard xM revision C
> > 
> > The USB enable GPIO has been in beagleboard xM revision C.
> > The USER button has been moved since beagleboard xM.
> > Also, board specific initialization has been moved to beagle_config
> > struct
> > and initialized in omap3_beagle_init_rev. Default values in struct are
> > for xMC.
> > 
> > Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> > Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> 
> Hope this isn't considered noise, but...
> 
> Ack.

Thanks, adding Acked-by: Jason Kridner <jkridner@beagleboard.org>
and adding this patch to devel-board branch for next merge window.

Jason, can you please reply with proper Acked-by next time?
This way patchwork.kernel.org will automatically add the acks
to the patch.

Regards,

Tony
