From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Mon, 12 Apr 2010 17:17:46 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E053D83@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
 <1270129320.2704.114.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41512 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab0DLLr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 07:47:59 -0400
In-Reply-To: <1270129320.2704.114.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, April 01, 2010 7:12 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> 
> On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > In case of 720P with 90/270 degree rotation, the system reports
> > GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not able to
> fill
> > the FIFO as per requirement.
> >
> > In TRM (section 11.2.6.1.3), where is has been clearly mentioned that,
> >
> > "To improve the performance on 90 degree rotation, split the data access
> on
> > write side and not read side."
> >
> > That means, read should always happen on 0 degree and write should go to
> > respective rotation view.
> 
> I haven't had time to look at this patch yet. I'll try to do it next
> week.
[Hiremath, Vaibhav] Tomi,

Have you had a chance to look at this patch/issue?

Thanks,
Vaibhav

> 
> However, I knew that TRM text when I was writing the code. The reason I
> chose to use 0 degree view for omapfb and change the view from DSS side
> was that it was difficult to handle mmapped areas in this case, if I
> recall right. I have to say I don't exactly remember what the problems
> were, so I need to read the code and think about this again.
> 
> Hmm, perhaps it was so that if you choose to change omapfb's VRFB view,
> you can only do that if nothing is mmapped. Which means that either you
> can only use one rotation angle defined at boot time, or you need
> carefully to remove all mmappings, including fb console, then change the
> view and recreate the mapping. And one requirement was that the rotation
> should be changeable at runtime, which made the select the current
> approach.
> 
>  Tomi
> 

