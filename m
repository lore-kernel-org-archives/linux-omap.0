From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Wed, 9 Feb 2011 11:34:45 +0530
Message-ID: <54f225541194205f01fe9f03b5110d16@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <0557426516de482c1769a50fa0b5f17a@mail.gmail.com> <20110208164747.GD6188@n2100.arm.linux.org.uk>
 <78d0134576ace6be5874871076cf0c10@mail.gmail.com> <alpine.LFD.2.00.1102081537010.14920@xanadu.home>
 <20110209003537.GQ20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46935 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815Ab1BIGEs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 01:04:48 -0500
Received: by mail-wy0-f175.google.com with SMTP id 40so6882968wyb.20
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 22:04:47 -0800 (PST)
In-Reply-To: <20110209003537.GQ20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, February 09, 2011 6:06 AM
> To: Nicolas Pitre
> Cc: Santosh Shilimkar; Russell King - ARM Linux; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
>
> * Nicolas Pitre <nico@fluxnic.net> [110208 12:41]:
> > On Tue, 8 Feb 2011, Santosh Shilimkar wrote:
> >
> > > > I think it's probably going to be better to _purposely_ break
> the
> > > > OMAP build when it covers v6 and v7 CPUs in these kernels as I
> don't
> > > > think it's sanely fixable given where we are.
> >
> > Agreed.  At least making SMP unavailable when both v6 and v7 are
> > configured should be small and good enough for 2.6.38-rc5.
>
> That's probably the best solution as then we can still do boot
> testing on all omap2plus_defconfig boards.
>
Just to be clear, are we saying disable SMP from omap2plus build.
If the v6, v7 is not fixable then, we also need a SMP
config for OMAP. Just boot test with SMP disable config for
OMAP4 is not enough.

Regards,
Santosh
