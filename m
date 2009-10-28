From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/2] Added board-3630.c file.
Date: Wed, 28 Oct 2009 16:24:45 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AD6D92C@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0C012AC22851@dlee02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE1C8@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA36ED28@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32795 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728AbZJ1VYl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 17:24:41 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SLOj1T018071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 16:24:45 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9SLOjiP026616
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 16:24:45 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9SLOjsW022979
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 16:24:45 -0500 (CDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA36ED28@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Pandita, Vikram
> Sent: Wednesday, October 28, 2009 7:14 PM
> To: Pais, Allen; Menon, Nishanth; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/2] Added board-3630.c file.
> 
> 
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pais,
> >Sent: Monday, October 26, 2009 4:40 PM
> >To: Pais, Allen; linux-omap@vger.kernel.org
> >Subject: RE: [PATCH 1/2] Added board-3630.c file.
> 
> >> Signed-off-by: Allen Pais <allen.pais@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/board-3630sdp.c |  188
> >> +++++++++++++++++++++++++++++++++++
> >>  1 files changed, 188 insertions(+), 0 deletions(-)  create mode
> >> 100644 arch/arm/mach-omap2/board-3630sdp.c
> >>
> >> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-
> >> omap2/board-3630sdp.c new file mode 100644 index 0000000..d3ddbd1
> >> --- /dev/null
> >> +++ b/arch/arm/mach-omap2/board-3630sdp.c
> >> @@ -0,0 +1,188 @@
> >> +/*
> >> +
> >
> >NAK. Could we follow the same issue with zoom2 -> break the keypad into a
> Separate one and use it
> >instead? Same for all reused zoom2 components..
> >
> >[Allen] Yes, we should do that. Not only for keypad but also
> >For display panel and touch screen so that sdp3630, zoom3 and
> >Zoom2 could use the same code, without having to duplicate
> >Code.
> 
> We just got the same image for zoom3 boot on SDP3630 (after mach-type
> change)
> The peripheral set is almost >90% same: same keypad, same display, same
> RAM, same NAND.
Ok zoom2,zoom3,sdp3630 -> might be good to compare. Here is a quick attempt:
Peripheral    zoom2    zoom3    sdp3630
NAND          A         B       B
SDRAM         A         B       B
Keypad        A         A       A
Camera        A         A       A
LCD Display   A         A       A
Power         A         A       A
HDMI          A         A       ??
Audio         A         A       ??
Voltage resources??
LEDs          A         A       A
OPPs          A         B       B
.... others?? ...
NOTE: I am just using A and B to show the types of devices. So the files registering the same type would probably be shared.. could you expand this list?

> 
> I see a good amount of re-use possible here.
> Here is how we could do it:
> 
> Board-zoom2.c
> Split into:
> 	Board-zoom2.c
> 	Board-zoom-peripheral.c [reuse]
> 
> 3630 zoom3 uses:
> 	Board-zoom3.c
> 	Board-zoom-peripheral.c [reuse]
> 
> 3630 SDP uses:
> 	Board-3630sdp.c
> 	Board-zoom-peripheral.c [reuse]
> 
> 
> Will give a first pass at this split up and post patches.
> 
Thanks..

Regards,
Nishanth Menon

