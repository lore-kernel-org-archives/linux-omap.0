From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: L-O master branch broken ?
Date: Thu, 18 Jun 2009 18:10:42 -0500
Message-ID: <A24693684029E5489D1D202277BE8944411FBF65@dlee02.ent.ti.com>
References: <00eb01c9eff8$13dba760$LocalHost@wipultra793>
	<20090618075257.GF8482@atomide.com>
	<011e01c9f000$fc86f8e0$LocalHost@wipultra793>
	<20090618102237.GI8482@atomide.com>
	<006701c9f023$aa55a170$LocalHost@wipultra793>
 <87tz2dsgmi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43768 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbZFRXJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 19:09:06 -0400
In-Reply-To: <87tz2dsgmi.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "V, Hemanth" <hemanthv@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, June 18, 2009 10:32 AM
> To: V, Hemanth
> Cc: Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: L-O master branch broken ?
> 
> "Hemanth V" <hemanthv@ti.com> writes:
> 
> > ----- Original Message -----
> > From: "Tony Lindgren" <tony@atomide.com>
> > To: "Hemanth V" <hemanthv@ti.com>
> > Cc: "Kevin Hilman" <khilman@deeprootsystems.com>;
> > <linux-omap@vger.kernel.org>
> > Sent: Thursday, June 18, 2009 3:52 PM
> > Subject: Re: L-O master branch broken ?
> >
> >
> >>* Hemanth V <hemanthv@ti.com> [090618 13:39]:
> >>> ----- Original Message ----- From: "Tony Lindgren" <tony@atomide.com>
> >>>
> >>>
> >>>>> I get the below error while compiling 3430SDP. I see below commit
> >>>>> as the
> >>>>> latest one.
> >>>
> >>>>
> >>>> Thanks, pushing a fix right now with the missing brace missing from
> >>>> Kevin's
> >>>> sram.c patch. Also moved around the defines so sram.c build for
> omap1.
> >>>>
> >>>
> >>> Booting still seems to have problems. Its hung after start kernel
> >>>
> >>>
> >>> Bytes transferred = 2480664 (25da18 hex)
> >>> ## Booting image at 80000000 ...
> >>>   Image Name:   Linux-2.6.30-omap1-06022-g6f4712
> >>>   Image Type:   ARM Linux Kernel Image (uncompressed)
> >>>   Data Size:    2480600 Bytes =  2.4 MB
> >>>   Load Address: 80008000
> >>>   Entry Point:  80008000
> >>>   Verifying Checksum ... OK
> >>> OK
> >>>
> >>> Starting kernel ...
> >>>
> >>
> >> Can you see what happens with DEBUG_LL enabled?
> >
> > Doesn't seem to show any additional messages even with
> > DEBUG_LL enabled
> 
> Since you don't even see 'Uncompressing Linux....', I'm guessing you
> have CONFIG_OMAP_LL_DEBUG_UART3=y in your .config
> 
> Try setting this to UART1.

I tried this on my SDP, and enabling both options, it boots!

But without enabling low level debug, it doesn't...

Does that ring any bells? Am I missing something?

Regards,
Sergio

> 
> Kevin
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

