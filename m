From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH] [RFC][PATCH 2/8] OMAP: DSS2: Add new Overlay Manager
Date: Thu, 1 Jul 2010 17:31:31 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305A41997@dbde02.ent.ti.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
	 <1277980285-20996-2-git-send-email-archit@ti.com>
	 <1277980285-20996-3-git-send-email-archit@ti.com>
 <1277984073.2474.322.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53899 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409Ab0GAMBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 08:01:42 -0400
In-Reply-To: <1277984073.2474.322.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

 
> On Thu, 2010-07-01 at 12:31 +0200, ext Archit Taneja wrote:
> > From: Sumit Semwal <sumit.semwal@ti.com>
> > 
> > Add new Overlay Manager in manager.c, make secondary 
> channel changes 
> > and update supported displays for the managers in OMAP4
> > 

<snip>

> > @@ -1471,15 +1471,25 @@ int 
> dss_init_overlay_managers(struct platform_device *pdev)
> >  		case 0:
> >  			mgr->name = "lcd";
> >  			mgr->id = OMAP_DSS_CHANNEL_LCD;
> > -			mgr->supported_displays =
> > -				OMAP_DISPLAY_TYPE_DPI | 
> OMAP_DISPLAY_TYPE_DBI |
> > -				OMAP_DISPLAY_TYPE_SDI | 
> OMAP_DISPLAY_TYPE_DSI;
> > +			mgr->supported_displays = 
> OMAP_DISPLAY_TYPE_DBI |
> > +				OMAP_DISPLAY_TYPE_DSI;
> > +			if (cpu_is_omap34xx())
> > +				mgr->supported_displays |=
> > +					OMAP_DISPLAY_TYPE_DPI |
> > +					OMAP_DISPLAY_TYPE_SDI;
> 
> How about OMAP2?

My bad, will fix this. Haven't tested it on omap2 yet.

> 
>  Tomi
> 
> 