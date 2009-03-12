From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
Date: Thu, 12 Mar 2009 14:01:14 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2C078@dbde02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF51DBC9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbZCLIcE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 04:32:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2C8VuZ4016728
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 03:32:02 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2C8Vt96027177
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 14:01:55 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51DBC9@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

Nishant,
 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, March 12, 2009 1:22 PM
> To: Gupta, Ramesh; linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> 
> > -----Original Message-----
> > From: Menon, Nishanth
> > Sent: Thursday, March 12, 2009 9:39 AM
> > To: Gupta, Ramesh; linux-omap@vger.kernel.org
> > Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> > Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> > 
> > > -----Original Message-----
> > > From: Gupta, Ramesh
> > > Sent: Thursday, March 12, 2009 8:01 AM
> > > To: Menon, Nishanth; linux-omap@vger.kernel.org
> > > Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> > > Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> > >
> > > I have tried this on linux-omap pm branch . This can be 
> applied on 
> > > top
> > of
> > > my DVFS
> > > Patches earlier.
> > >
> > Your patch does not apply clean :(
> > $ wget -O ramesh.auto.patch "http://marc.info/?l=linux- 
> > omap&m=123683598308417&q=raw"
> > $ vim ramesh.auto.patch (edited to remove the linux-omap trailer) $ 
> > patch -p1<./ramesh.auto.patch --dry-run patching file 
> > drivers/dsp/bridge/rmgr/drv_interface.c
> > Hunk #1 succeeded at 400 (offset -5 lines).
> > Hunk #2 succeeded at 408 (offset -5 lines).
> > Hunk #3 succeeded at 450 with fuzz 1 (offset -5 lines).
> > Hunk #4 succeeded at 470 (offset -5 lines).
> > Hunk #5 succeeded at 655 (offset -5 lines).
> > 
> > Could you rebase your patch against the following:
> > git clone 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
> > 2.6.git
> > cd linux-omap-2.6.git
> > git checkout -b pm --track origin/pm
> > git fetch git://gitorious.org/lk/mainline.git 
> > tidspbridge-pm:tidspbridge- pm git checkout tidspbridge-pm 
> git merge 
> > pm
> 
> 
> And the patch does not work :(

What is your code base? It does work for me. 

# insmod ./bridgedriver.ko phys_mempool_base=0x87000000 phys_mempool_size=0x6000
00 shm_size=0x400000 base_img=./baseimage.dof
# <4>SR1: VDD autocomp is not active
SR1: VDD autocomp is not active
<4>SR1: VDD autocomp is not active
SR1: VDD autocomp is not active

# insmod ./bridgedriver.ko phys_mempool_base=0x87000000 phys_mempool_size=0x6000
00 shm_size=0x400000 base_img=./b

# rmmod bridgedriver.ko

# insmod ./bridgedriver.ko phys_mempool_base=0x87000000 phys_mempool_size=0x6000
00 shm_size=0x400000 base_img=./ddspbase_tiomap3430.dof64P
# ./ping.out 3
DSP device detected !!
DSPNodeCreate succeeded
DSPNode_registerNotify succeeded
DSPNode_run succeeded
Ping: Id 1.000000 Msg 0.000000 Mem 15384.000000
Ping: Id 1.000000 Msg 1.000000 Mem 15384.000000
Ping: Id 1.000000 Msg 2.000000 Mem 15384.000000

I will rebase the patch as you suggested.

Regards
Ramesh Gupta G 