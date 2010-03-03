From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
Date: Wed, 3 Mar 2010 07:43:35 -0600
Message-ID: <A24693684029E5489D1D202277BE894453C080ED@dlee02.ent.ti.com>
References: <1267536955-31268-1-git-send-email-manjugk@ti.com>
 <A24693684029E5489D1D202277BE894453B624B1@dlee02.ent.ti.com>
  <E0D41E29EB0DAC4E9F3FF173962E9E94026ED966D3@dbde02.ent.ti.com>
 <A24693684029E5489D1D202277BE894453C080DC@dlee02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026ED96A2E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40304 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0CCNnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:43:40 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026ED96A2E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Wednesday, March 03, 2010 7:39 AM
> To: Aguirre, Sergio; linux-omap@vger.kernel.org
> Cc: Tony Lindgren; Shilimkar, Santosh; Raja, Govindraj
> Subject: RE: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
> 
> 
> 
> > > To update further, it seems to be working on zoom3 with ttyS0
> > > with following combination of patches:
> > >
> > > 1.
> > > [RFC,part2,v1,4/4] omap3: zoom 2/3: Change debugboard serial port id
> > > [RFC,part2,v1,3/4] omap3: 3630sdp: Explicitly enable all UARTs
> > > [RFC,part2,v1,2/4] omap3: zoom2/3 / 3630sdp: Don't init
> > always all uarts
> > > [RFC,part2,v1,1/4] omap2/3/4: serial: rename omap_serial_init
> > >
> > > 2.
> > > [RESEND,PATCH/RFC] OMAP2: serial.c: Fix number of uarts in
> > early_init
> > >
> > > 3.
> > > [RFC,v3,6/6] omap3: serial: Fix uart4 handling for 3630
> > > [RFC,v3,5/6] OMAP3: PRCM: Consider UART4 for 3630 chip in
> > prcm_setup_regs
> > > [RFC,v3,4/6] OMAP clock: Add uart4_ick/fck definitions for 3630
> > > [RFC,v3,3/6] ARM: OMAP3630: PRCM: Add UART4 control bits
> > > [RFC,v3,2/6] omap2/3/4: serial: Remove condition for
> > getting uart4_phys
> > > [RFC,v3,1/6] OMAP3: serial: Check for zero-based physical addr
> >
> > Yeah, that should be the total patchlist applied.
> >
> > I'm assuming you're applying from bottom to top order in your
> > list above...
> 
> Yes. But, you will be dropping v1 part2 series right?

I'll just drop patch #0001 in that series, and resend.

Actually, I'll group the 2 series and resend in a single batch, just to be clear on the dependency between them.

Regards,
Sergio

> 
> Regards,
> Manjunath
