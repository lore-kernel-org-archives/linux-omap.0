From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Tue, 30 Mar 2010 18:35:19 -0500
Message-ID: <005401cad061$a8db7440$544ff780@am.dhcp.ti.com>
References: <20100322212025.GW11448@atomide.com> <E0D41E29EB0DAC4E9F3FF173962E9E94026F127117@dbde02.ent.ti.com> <20100323152709.GD11448@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37401 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab0C3Xfa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 19:35:30 -0400
In-Reply-To: <20100323152709.GD11448@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>, "'Pais, Allen'" <allen.pais@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "'Pandita, Vikram'" <vikram.pandita@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, March 23, 2010 10:27 AM
> To: Pais, Allen
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> Pandita, Vikram
> Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
> 
> * Pais, Allen <allen.pais@ti.com> [100322 22:42]:
> > > >
> > > >  With this patch[DEBUG_LL + earlyprintk],
> > > >  I still haven't been able to boot the kernel.
> > > >  Is it working on your side.
> > > >
> > > >  The commit am using is : a842b5f9ce70e1b738eabb4d719860070180ed1c
> > >
> > > I think you will also need the 3630 serial fixes series posted
> > > recently.
> > >
> > > I just merged those into omap-fixes-for-linus (and master)
> > > branch(es). Maybe give it a try with at commit
> > > b3c7740a120c8a7775cb63b4d094466da5c01692 + this patch?
> >
> >   Thanks, I'll pull in those fixes.
> >  I believe the mux errors are fixed. Have a look at
> >  http://dev.omapzoom.org/?p=manju/kernel-omap3-
> dev.git;a=commit;h=3499f5023ee90dc6ee3868a3147b87fe22a1d9b7
> >
> >  Patch must have been missed some how.
> 
> OK, we really should get fixes like that to mainline kernel ASAP
> to avoid duplicating the effort.
> 
> Then at least one issue remains for zoom3 to be usable..
> I'm getting tons of MMC errors trying to mount root on it:
> 
> mmcblk1: error -110 transferring data, sector 2097024, nr 8, card status
> 0x900
> end_request: I/O error, dev mmcblk1, sector 2097024
> ...
> 
> Any ideas if that's fixed somewhere also?
> 
Tony,

What is the branch on which the kernel is built? I tried the master branch
and the omap-fixes-for-linus both does not seem to boot Zoom3.

Regards,
Madhu

> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

