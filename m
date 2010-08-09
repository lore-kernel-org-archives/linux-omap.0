From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
Date: Mon, 9 Aug 2010 18:23:49 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EF4D594@dbde02.ent.ti.com>
References: <1278104096-27809-1-git-send-email-notasas@gmail.com>
 <1280836944.3436.135.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35839 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755969Ab0HIMx5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 08:53:57 -0400
In-Reply-To: <1280836944.3436.135.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, August 03, 2010 5:32 PM
> To: ext Grazvydas Ignotas
> Cc: linux-fbdev@vger.kernel.org; linux-omap@vger.kernel.org; Hiremath,
> Vaibhav
> Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: add support for FBIO_WAITFORVSYNC
> 
> On Fri, 2010-07-02 at 22:54 +0200, ext Grazvydas Ignotas wrote:
> > FBIO_WAITFORVSYNC is a stardard ioctl for waiting vsync, already
> > used by some userspace, so add it as an alias for OMAPFB_WAITFORVSYNC.
> >
> > Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> > ---
> > Tomi,
> >
> > I know I already sent this earlier, but as now FBIO_WAITFORVSYNC is a
> > standard ioctl, so why don't we support it? I know you might not like
> > that omapfb_ioctl will have one standard ioctl handler between all OMAP
> > specific ones, but that's something plenty of other drivers do.
> 
> One could ask that if FBIO_WAITFORSYNC is a standard ioctl, why do we
> need to handle it in omapfb's custom ioctl function =).
> 
> But I think this is fine, I'll apply.
[Hiremath, Vaibhav] I still think we should mark the old (custom) interface as deprecated and add new standard ioctl interface here, so that in the future we can remove custom one.

Thanks,
Vaibhav

> 
>  Tomi
> 

