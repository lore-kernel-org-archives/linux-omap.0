From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH] OMAP: Exporting functions doing common register access
Date: Wed, 18 Nov 2009 11:59:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA8F7@dbde02.ent.ti.com>
References: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com>
 <alpine.DEB.2.00.0911161408260.29213@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EC2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33818 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbZKRG3E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 01:29:04 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EC2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aggarwal, Anuj
> Sent: Tuesday, November 17, 2009 11:28 AM
> To: Paul Walmsley
> Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org
> Subject: RE: [PATCH] OMAP: Exporting functions doing common register
> access
> 
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, November 17, 2009 2:46 AM
> > To: Aggarwal, Anuj
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP: Exporting functions doing common register
> > access
> >
> > Hello Anuj,
> >
> > On Mon, 16 Nov 2009, Anuj Aggarwal wrote:
> >
> > > These functions need to be exported so that drivers (e.g. McBSP) can
> > > be configured as modules.
> > >
> > > McBSP driver gets built as a module when ASoC driver for OMAP3 EVM
> > > is configured as module. McBSP driver uses functions like
> > > omap_ctrl_readl/omap_ctrl_writel, which are defined in control.c
> > > file but not exported. Without that, McBSP driver fails to build as
> > > a module.
> > >
> > > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> >
> > This will prevent the McBSP driver from being usable across chips.  For
> > example, if a future OMAP comes out with McBSP clock source switching
> > implemented in a different way, or if a DaVinci chip comes out with a
> > McBSP block but no SCM block, this either won't build or won't run.
> >
> > A better approach would be to move the OMAP2/3-specific functions from
> the
> > McBSP driver into the OMAP McBSP integration code,
> > arch/arm/*omap*/mcbsp.c, and to define function pointers in
> > struct platform_data for these functions, and to pass them from the
> > integration code into the device driver code.  That will make these
> > drivers independent of chip integration details.
> Sorry to confuse you, I was talking about the platform specific ASoC-McBSP
> code for OMAP (file - sound/soc/omap/omap-mcbsp.c) platform. The McBSP
> driver - both platform and machine specific - doesn't use the functions
> exported by the patch.
> 
> Including alsa-devel list too...
[Aggarwal, Anuj] Any comments on this patch? Do I have to re-work this?
> >
> >
> > - Paul
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

