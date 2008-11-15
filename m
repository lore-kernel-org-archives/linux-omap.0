From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Sat, 15 Nov 2008 14:27:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5F2B762@dbde02.ent.ti.com>
References: <BEB852B4-C5D3-44AF-A860-DF9498363302@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56013 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbYKOI5z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Nov 2008 03:57:55 -0500
In-Reply-To: <BEB852B4-C5D3-44AF-A860-DF9498363302@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> Sent: Saturday, November 15, 2008 2:21 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org List
> Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis
> FBDEV/DSS Patches
> 
> 
> Op 15 nov 2008, om 09:45 heeft Hiremath, Vaibhav het volgende
> geschreven:
> 
> >
> >
> > Thanks,
> > Vaibhav Hiremath
> >
> >> -----Original Message-----
> >> From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> >> Sent: Saturday, November 15, 2008 1:14 AM
> >> To: Tomi Valkeinen
> >> Cc: Hiremath, Vaibhav; linux-fbdev-devel@lists.sourceforge.net;
> >> linux-omap@vger.kernel.org
> >> Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis
> >> FBDEV/DSS Patches
> >>
> >>
> >> Op 14 nov 2008, om 16:53 heeft Tomi Valkeinen het volgende
> >> geschreven:
> >>
> >>> Hi,
> >>> On Fri, 2008-11-14 at 18:05 +0530, ext Hiremath, Vaibhav wrote:
> >>>
> >>>>>
> >>>>> I think the LCD panel on SDP and EVM boards are the same, so
> we
> >>>>> should
> >>>>> only have one driver. Do you have specifications about the
> LCD?
> >> The
> >>>>> manufacturer, model etc?. I didn't find any proper information
> >> about
> >>>>> the
> >>>>> LCD.
> >>>>>
> >>>> [Hiremath, Vaibhav] The LCD on OMAP3EVM is Sharp LCD (Model No.
> -
> >>>> LS037V7DW01).
> >>>> Koen has already conformed that panel3430sdp.c is working with
> >>>> OMAP3EVM, let me try at my end. If it works properly then we
> can
> >>>> have same file to build for both SDP and EVM. But in that case
> it
> >>>> make sense to rename file to panel-lcd.c.
> >>>>
> >>>
> >>> I took the liberty to add you EVM changes to my tree, with a
> >> comment
> >>> about the origin. I also changed the SDP panel name to sharp
> >> panel,
> >>> and
> >>> made both EVM and SDP use that. But I can't test the EVM, as I
> >> don't
> >>> have one.
> >>
> >> I finally got rc4 working on evm and with your latest patches I
> get:
> >>
> > [Hiremath, Vaibhav] What was the issue you figured out?
> 
> I figured out which patch to use to fix MMC on evm.
> 
> 
> >> udevd version 124 started
> >> eth0: link down
> >> eth0: link up, 100Mbps, full-duplex, lpa 0x8DE1
> >> DSS2 debug: best_ld is 1, best_pd is 3
> >> DSS2 debug: best_ld is 1, best_pd is 3
> >> DSS2 debug: best.lck_div is 1, best.pck_div is 3
> >> omap-dss DISPLAY: omap_dss_mgr_apply(lcd)
> >> omap-dss DISPC: dispc_setup_plane 0, 87200000, sw 480, 0,0,
> 480x640
> >> ->
> >> 480x640, (ilace 0)
> >> omap-dss DISPC: dispc_enable_plane 0, 1
> >> omap-dss DISPC: dispc_enable_plane 1, 0
> >> omap-dss DISPC: dispc_enable_plane 2, 0
> >> omap-dss DISPC: GO LCD
> >> Division by zero in kernel.
> > [Hiremath, Vaibhav] Are you using the patch I submitted or the
> > merged code from Tomi?
> 
> I'm using the merged code from Tomi. I extracted the patches from
> his
> git tree:
> http://gitweb.openembedded.net/?p=openembedded.git;a=commit;h=5f7bde
> 74179a9eac56e874687f4837d3af759878
> 
[Hiremath, Vaibhav] Let me have a look at his changes then.

> regards,
> 
> Koen

