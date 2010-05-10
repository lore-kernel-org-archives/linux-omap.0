From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH] DSS2 Include VRFB into omap2-3build only
Date: Mon, 10 May 2010 13:31:20 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030428879D@dbde02.ent.ti.com>
References: <1273474110-22451-1-git-send-email-svadivu@ti.com>
 <1A2F53DA-903A-4667-A27F-492A3499F7ED@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53506 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab0EJIBc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 04:01:32 -0400
In-Reply-To: <1A2F53DA-903A-4667-A27F-492A3499F7ED@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Building a multi-omap kernel is not impacted as long as the display is not choosen in the build.  Usually display is chosen from the board file.

> -----Original Message-----
> From: Koen Kooi [mailto:koen@dominion.thruhere.net] 
> Sent: Monday, May 10, 2010 1:10 PM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; 
> linux-fbdev-devel@lists.sourceforge.net; tony@atomide.com; 
> tomi.valkeinen@nokia.com; Hiremath, Vaibhav
> Subject: Re: [PATCH] DSS2 Include VRFB into omap2-3build only
> 
> 
> Op 10 mei 2010, om 08:48 heeft Senthilvadivu Guruswamy het 
> volgende geschreven:
> 
> > Exclude VRFB from OMAP4 onwards and include only for
> > OMAP2 and OMAP3 builds.  In OMAP4 VRFB HW IP is replaced
> > with a new HW IP "TILER"
> > 
> > --- a/drivers/video/omap2/Kconfig
> > +++ b/drivers/video/omap2/Kconfig
> > @@ -3,6 +3,10 @@ config OMAP2_VRAM
> > 
> > config OMAP2_VRFB
> > 	bool
> > +	depends on FB_OMAP2 && (!ARCH_OMAP4)
> > +	default y if (ARCH_OMAP2 || ARCH_OMAP3)
> > +	help
> > +	  OMAP VRFB buffer support is efficient for rotation
> 
> How does this work for multi-omap kernels, e.g. building a 
> kernel with beagle and panda support?
> 
> regards,
> 
> Koen