From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
Date: Wed, 3 Mar 2010 11:30:47 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026ED96660@dbde02.ent.ti.com>
References: <1267536955-31268-1-git-send-email-manjugk@ti.com>
 <A24693684029E5489D1D202277BE894453B624B1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55478 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787Ab0CCGAx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 01:00:53 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894453B624B1@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Sergio,

> -----Original Message-----
> From: Aguirre, Sergio 
> Sent: Tuesday, March 02, 2010 9:41 PM
> To: G, Manjunath Kondaiah; linux-omap@vger.kernel.org
> Cc: G, Manjunath Kondaiah; Tony Lindgren; Shilimkar, Santosh; 
> Raja, Govindraj
> Subject: RE: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
> 
> Manju,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Manjunatha GK
> > Sent: Tuesday, March 02, 2010 7:36 AM
> > To: linux-omap@vger.kernel.org
> > Cc: G, Manjunath Kondaiah; Tony Lindgren; Shilimkar, Santosh; Raja,
> > Govindraj
> > Subject: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
> > 
> > The commit id "5550bc33a1a9002976022cc794fe8c52ad9a0021" seems to be
> > broken
> > zoom3 boot which adds support for UART4 on OMAP4 and OMAP3630.
> > 
> > But, it looks like OMAP3630 UART4 interface and functional 
> clock nodes
> > needs
> > to be added for omap3630. Thus limiting no. of UART's for 
> 3630 to 3 to
> > prevent
> > boot up issues until clock nodes are added for UART4 on OMAP3630.
> 
> I already tried a similar patch here:
> 
> http://patchwork.kernel.org/patch/81692/
> 
> But as it is really not solving anything, and Tony rejected 
> it, I started working on the needed bits to get UART4 
> enabled, therefore I have came up with this patch series:
> 
> - [RFC v3][PATCH 0/6] OMAP3630: UART4 startup (+ new bugfix!) [1]
> 
> Also, I'm working in my spare time on a cleanup proposal [2], 
> which I'll repost today, given some comments from Kevin.
> 
> So, if you want to boot, take series [1] and [2], and then 
> you should be able to boot with ttyS0.

Sergio, did you test this combination on zoom3? It seems to be not working
on zoom3 with ttyS0 and also with ttyS3.

Where as, reducing number of uarts(for 3630) to 3 seems to working fine for 
ttyS3 on zoom3.

-Manjunath


