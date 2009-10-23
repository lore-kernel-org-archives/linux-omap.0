From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 3/3] omap: zoom3: add zoom3 board support
Date: Fri, 23 Oct 2009 15:07:57 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781BAB@dlee02.ent.ti.com>
References: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-3-git-send-email-vikram.pandita@ti.com>,<1256325806-14400-4-git-send-email-vikram.pandita@ti.com>
 <A24693684029E5489D1D202277BE89444B781BAA@dlee02.ent.ti.com>,<4AE2081E.7070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49120 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbZJWUHx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 16:07:53 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9NK7wx2003895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 15:07:58 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9NK7wju017719
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 15:07:58 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9NK7vN7004377
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 15:07:57 -0500 (CDT)
In-Reply-To: <4AE2081E.7070501@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Menon, Nishanth
Sent: Friday, October 23, 2009 2:46 PM
> Aguirre Rodriguez, Sergio Alberto had written, on 10/23/2009 02:39 PM,
> the following:
> > Vikram,
> >
> > Just some comments I came across below.
> >
> > From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> > Sent: Friday, October 23, 2009 2:23 PM
> >> Add machine type support for zoom3 board
> >> Add board type in Kconfig and Makefile
> >> Reused the zoom board file for zoom2 and zoom3
> >>
> >> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/Kconfig             |    4 ++++
> >>  arch/arm/mach-omap2/Makefile            |    3 +++
> >>  arch/arm/mach-omap2/board-zoom2-zoom3.c |    4 ++++
> >>  3 files changed, 11 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >> index 8685df5..fa20996 100644
> >> --- a/arch/arm/mach-omap2/Kconfig
> >> +++ b/arch/arm/mach-omap2/Kconfig
> >> @@ -97,6 +97,10 @@ config MACH_OMAP_ZOOM2
> >>         bool "OMAP3 Zoom2 board"
> >
> > How about also clarifying here ^^ the chip version:
> >
> >          bool "OMAP3430 Zoom2 board"
> >
> > I mean, just to stick to the convention you're putting below.
> >
> >>         depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >>
> >> +config MACH_OMAP_ZOOM3
> >> +       bool "OMAP3630 Zoom3 board"
> >> +       depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >
> > Shouldn't this be:
> >
> >        depends on ARCH_OMAP3 && ARCH_OMAP36XX
> >
> is there an ARCH_OMAP36XX? i believe not ;)..
> 

Hmm... (Had this discussion before, not going there...)

> 
> Linux-OMAP build allows for both boards to be defined at the same time..
> so in theory you could have a single uImage. the strategy followed here
> will fail it.. since the board file is the same one.. it could be made
> to work though..
> 

Not with this approach :)

How about making board-zoom3.c separate from board-zoom2.c, and do a
smarter way to share as much as possible?

To modularize, I'll suggest taking a look at RX51 board files. That way you can have
board-zoom2.c, board-zoom3.c, with the modules shared accordingly in Makefile.

Camera is already doing that ;)

What do you think?

Regards,
Sergio
