From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: DSS2: SYNC Lost error on mirroring enabled
Date: Fri, 29 May 2009 15:20:08 +0300
Message-ID: <1243599608.18862.2.camel@tubuntu>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35E96@dlee01.ent.ti.com>
	 ,<1243579899.32558.40.camel@tubuntu>
	 <5F744A5A3C131242B81CE5874BD2CFFB34E35E98@dlee01.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54298 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225AbZE2MUO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 08:20:14 -0400
In-Reply-To: <5F744A5A3C131242B81CE5874BD2CFFB34E35E98@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Venkatesh, Subbu" <subbu.wrs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shah, Hardik" <hardik.shah@ti.com>, "Castaneda Gonzalez, Axel" <x0055901@ti.com>, "Mande, Nikhil" <nikhil@ti.com>

Hi,

On Fri, 2009-05-29 at 14:06 +0200, ext Venkatesh, Subbu wrote:
> Hello Tomi,
> I have no problem with the Roatation using VRFB.
> Curretnly the issue is with the Mirroring. Using VRFB for mirroring has no effect as I see in the omapfb-main.c, if Rotation type is VRFB, then mirror=0. So I cannot use mirroring at all.

I meant that VRFB is used also for mirroring, and so you need VRFB.

But true, VRFB mirroring is currently disabled, and doesn't seem to
work.

 Tomi

> 
> Regards,
> Subbu
> ________________________________________
> From: Tomi Valkeinen [tomi.valkeinen@nokia.com]
> Sent: Friday, May 29, 2009 1:51 AM
> To: Venkatesh, Subbu
> Cc: linux-omap@vger.kernel.org; Shah, Hardik; Castaneda Gonzalez, Axel; Mande, Nikhil
> Subject: Re: DSS2: SYNC Lost error on mirroring enabled
> 
> On Fri, 2009-05-29 at 03:32 +0200, ext Venkatesh, Subbu wrote:
> > Hi,
> > I am getting SYNC LOSTerror on OMAP development board ( LDP ), this happens when I  enable mirroring by a command
> >
> > #echo 1 > /sys/class/graphics/fb0/mirror
> >
> > In brief, recently I ported board related funtions to support both LCD and TV displays on Omap LDP, mirroring works on TV but not LCD.  Attached log gives more details.
> > Any inputs are appreciated.
> 
> You need to use VRFB rotation, DMA rotation is only meant for SRAM
> framebuffers.
> 
>  Tomi
> 
> 
> 

