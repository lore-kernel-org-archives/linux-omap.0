From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
Date: Wed, 31 Mar 2010 11:46:37 -0500
Message-ID: <003c01cad0f1$bb260fd0$544ff780@am.dhcp.ti.com>
References: <20100322212025.GW11448@atomide.com> <E0D41E29EB0DAC4E9F3FF173962E9E94026F127117@dbde02.ent.ti.com> <20100323152709.GD11448@atomide.com> <005401cad061$a8db7440$544ff780@am.dhcp.ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E94026F32346C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58043 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604Ab0CaQsS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 12:48:18 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026F32346C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'G, Manjunath Kondaiah'" <manjugk@ti.com>, 'Tony Lindgren' <tony@atomide.com>, "'Pais, Allen'" <allen.pais@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "'Pandita, Vikram'" <vikram.pandita@ti.com>



> -----Original Message-----
> From: G, Manjunath Kondaiah [mailto:manjugk@ti.com]
> Sent: Wednesday, March 31, 2010 1:11 AM
> To: Chikkature Rajashekar, Madhusudhan; 'Tony Lindgren'; Pais, Allen
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> Pandita, Vikram
> Subject: RE: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
> 
> Master branch will work fine for omap_zoom3_defconfig. Pls make sure to
> use ttyS0 in bootargs.
> 
Yes. That works.

Thanks,
Madhu

> OMAP36XX ZOOM3 # boot
> LAN9x18 (0x92210000) detected.
> Read mac address: 00:08:EE:03:7D:EE
> start Auto negotiation... (take ~2sec)
> Auto negotiation complete, 100BaseTX, full duplex
> TFTP from server 172.24.136.151; our IP address is 172.24.190.192; sending
> through gateway 172.24.188.1
> Filename 'uImage_zoom3'.
> Load address: 0x80300000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ##########################################################
> done
> Bytes transferred = 1959780 (1de764 hex)
> ## Booting image at 80300000 ...
>    Image Name:   Linux-2.6.34-rc2-07865-g2e51807
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1959716 Bytes =  1.9 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Linux version 2.6.34-rc2-07865-g2e51807 (manju@u-host) (gcc version 4.3.3
> (Sourcery G++ Lite 2009q1-203) ) #5 Wed Mar 31 11:51:19 IST 2010
> CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP Zoom3 board
> Memory policy: ECC disabled, Data cache writeback
> OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
> SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> Kernel command line: console=ttyS0,115200n8 root=/dev/nfs rw
> nfsroot=172.24.136.151:/home/manju/fs/alsa-fs
> target,nolock,tcp,rsize=1024,wsize=1024 mem=128M ip=dhcp
> 
> Regards,
> Manjunath
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > Chikkature Rajashekar, Madhusudhan
> > Sent: Wednesday, March 31, 2010 5:05 AM
> > To: 'Tony Lindgren'; Pais, Allen
> > Cc: linux-arm-kernel@lists.infradead.org;
> > linux-omap@vger.kernel.org; Pandita, Vikram
> > Subject: RE: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
> >
> >
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > > Sent: Tuesday, March 23, 2010 10:27 AM
> > > To: Pais, Allen
> > > Cc: linux-arm-kernel@lists.infradead.org;
> > linux-omap@vger.kernel.org;
> > > Pandita, Vikram
> > > Subject: Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3
> > >
> > > * Pais, Allen <allen.pais@ti.com> [100322 22:42]:
> > > > > >
> > > > > >  With this patch[DEBUG_LL + earlyprintk],
> > > > > >  I still haven't been able to boot the kernel.
> > > > > >  Is it working on your side.
> > > > > >
> > > > > >  The commit am using is :
> > a842b5f9ce70e1b738eabb4d719860070180ed1c
> > > > >
> > > > > I think you will also need the 3630 serial fixes series posted
> > > > > recently.
> > > > >
> > > > > I just merged those into omap-fixes-for-linus (and master)
> > > > > branch(es). Maybe give it a try with at commit
> > > > > b3c7740a120c8a7775cb63b4d094466da5c01692 + this patch?
> > > >
> > > >   Thanks, I'll pull in those fixes.
> > > >  I believe the mux errors are fixed. Have a look at
> > > >  http://dev.omapzoom.org/?p=manju/kernel-omap3-
> > > dev.git;a=commit;h=3499f5023ee90dc6ee3868a3147b87fe22a1d9b7
> > > >
> > > >  Patch must have been missed some how.
> > >
> > > OK, we really should get fixes like that to mainline kernel ASAP
> > > to avoid duplicating the effort.
> > >
> > > Then at least one issue remains for zoom3 to be usable..
> > > I'm getting tons of MMC errors trying to mount root on it:
> > >
> > > mmcblk1: error -110 transferring data, sector 2097024, nr
> > 8, card status
> > > 0x900
> > > end_request: I/O error, dev mmcblk1, sector 2097024
> > > ...
> > >
> > > Any ideas if that's fixed somewhere also?
> > >
> > Tony,
> >
> > What is the branch on which the kernel is built? I tried the
> > master branch
> > and the omap-fixes-for-linus both does not seem to boot Zoom3.
> >
> > Regards,
> > Madhu
> >
> > > Regards,
> > >
> > > Tony
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

