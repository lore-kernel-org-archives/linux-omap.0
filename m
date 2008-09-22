From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [PATCH 05/06][omapzoom] BRIDGE: Fix header path name to
 "arch/arm/plat-omap/include/dspbridge"
Date: Mon, 22 Sep 2008 09:02:52 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344B3DE39@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A5344B3DCD7@dlee03.ent.ti.com>
 <20080920.091012.233900997.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53411 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbYIVODG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 10:03:06 -0400
In-Reply-To: <20080920.091012.233900997.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> > sed -i -e \
> > 's@arch/arm/plat-omap/include/bridge@arch/arm/plat-
> omap/include/dspbridge@g' \
> > drivers/dsp/bridge/Kbuild \
> > drivers/dsp/bridge/*/*.[ch] \
> > arch/arm/plat-omap/include/dspbridge/*.h
> >
> > - * dspbridge/inc/chnl_sm.h
> > + * dsplinux/arch/arm/plat-omap/include/dspbridge//chnl_sm.h
> 
> It seems that you ran the wrong script;)
> 
> Also it may be better that the paths are omitted as David Brownell
> suggested in another mail.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04551.html
> 
> 	Hiroshi DOYU

Missed that, thanks for the review, I'll take your advise and change it.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,

Omar
