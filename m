From: "Venkatesh, Subbu" <subbu.wrs@ti.com>
Subject: RE: DSS2: SYNC Lost error on mirroring enabled
Date: Mon, 1 Jun 2009 12:53:21 -0500
Message-ID: <5F744A5A3C131242B81CE5874BD2CFFB34E35EA7@dlee01.ent.ti.com>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35E96@dlee01.ent.ti.com>
	 ,<1243579899.32558.40.camel@tubuntu>
	 <5F744A5A3C131242B81CE5874BD2CFFB34E35E98@dlee01.ent.ti.com>,<1243599608.18862.2.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52218 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZFARzq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 13:55:46 -0400
In-Reply-To: <1243599608.18862.2.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shah, Hardik" <hardik.shah@ti.com>, "Castaneda Gonzalez, Axel" <x0055901@ti.com>, "Mande, Nikhil" <nikhil@ti.com>

Hi Tomi,
I managed to fix the Mirroring UNDERFLOW error on LDP board. It was pixel clock issue. 
I also emailed you patch supporting LDP DSS2, could you comment on it.

Regards,
Subbu
________________________________________
From: Tomi Valkeinen [tomi.valkeinen@nokia.com]
Sent: Friday, May 29, 2009 7:20 AM
To: Venkatesh, Subbu
Cc: linux-omap@vger.kernel.org; Shah, Hardik; Castaneda Gonzalez, Axel; Mande, Nikhil
Subject: RE: DSS2: SYNC Lost error on mirroring enabled

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


