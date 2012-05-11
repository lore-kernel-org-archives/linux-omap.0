From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
Date: Fri, 11 May 2012 13:11:13 -0700
Message-ID: <20120511201113.GA21851@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14393 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab2EKULP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 16:11:15 -0400
Content-Disposition: inline
In-Reply-To: <e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi,

* Sricharan R <r.sricharan@ti.com> [120510 10:47]:
> Hi Tony,
> 
> > -----Original Message-----
> > From: R Sricharan [mailto:r.sricharan@ti.com]
> > Sent: Thursday, May 03, 2012 12:56 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org; santosh.shilimkar@ti.com;
> > tony@atomide.com; b-cousson@ti.com; r.sricharan@ti.com
> > Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
> >
> > The series adds minimal OMAP5 support.
> > OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
> > L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and
> > hence large part of the peripherals are re-used.
> >
> > OMAP5432 is another variant of OMAP5430, with a
> > memory controller supporting DDR3 and SATA.
> >
>  OMAP5 V2 series is ready with all comments addressed, but I have
>  below dependencies to be merged to apply my series against your
>  cleanup-soc branch

OK
 
>  1) git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5

This one is not merged in yet and it seems that we're out of time
for v3.5 unless it drags on and we have -rc8 after -rc7.

>  2) git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.5
>  3) https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup

These two are merged in arm-soc now.

>  4) http://www.spinics.net/lists/arm-kernel/msg174461.html

I think this series still has some pending comments?
 
>  Can you please let me know how you want me to prepare the series
>  with these dependencies.

Until these dependencies get cleared out, it seems that the best
branch to base your patches is omap-cleanup-timer-for-v3.5 tag
and just carry the pending patches for a little bit longer.

Regards,

Tony
