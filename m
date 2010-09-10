From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Fri, 10 Sep 2010 16:08:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD17EF59@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwxjx7qj.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EDFA@dbde02.ent.ti.com>
 <87y6bavrn3.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD17EE0A@dbde02.ent.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40243 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356Ab0IJKir convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 06:38:47 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Friday, September 10, 2010 4:00 PM
> To: Shilimkar, Santosh; Kevin Hilman
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH 0/7] omap4: Fixes, hacks for es2.0
> 
> 
> 
> > -----Original Message-----
> [..snip..]
> > > >>
> > > >> > The series is boot tested tested on 4430 SDP, Blaze with
> > > >> > omap_4430sdp_defconfig with file over NFS and MMC.
> > > >> >
> > > >> > Also boot tested omap3_defconfig with ramdisk on OMAP4 and OMAP3
> > > >> > SDPs. Same observation with Panda
> > > >> >
> > > >> > With omap3_defconfig, MMC while mounting the rootfs over MMC, the
> > > >> > boot hangs. Same observation with Panda
> > > >>
> > > >> On my ES2.0 Panda, rootfs on MMC is now working with this series.
> > > >>
> > > > I observed the same with MMC. Ramdisk boot worked for me on PANDA.
> > >
> > > Note that I said "now working".  I think you read my message as "not
> > > working."
> > >
> > Yes I read it otherway ... Second time today :)
> >
> > > IOW, rootfs on MMC *is* working for me on my es2.0 Panda.   I applied
> > > your series to current l-o master, and it works.
> > >
> > Cool!!
> 
> [Ghorai] I have tested MMC/SD boot using omap3_defconfig on ZOOM3, 4430
> ES2.0 SDP, Blaze and Panda and all booting fine.
> 
> And omap_4430sdp_defconfig also ok omap4.
> 
Thanks Sukumar!!
So with this testing data, the series works fine on 
all boards now with rootfs over MMC.

Regards,
Santosh
