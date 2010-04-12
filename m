From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Mon, 12 Apr 2010 19:12:52 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E053DDE@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
	 <1270129320.2704.114.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044E053D83@dbde02.ent.ti.com>
 <1271073749.2690.52.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57401 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab0DLNnH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 09:43:07 -0400
In-Reply-To: <1271073749.2690.52.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Monday, April 12, 2010 5:32 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> 
> On Mon, 2010-04-12 at 13:47 +0200, ext Hiremath, Vaibhav wrote:
> > > -----Original Message-----
> > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > Sent: Thursday, April 01, 2010 7:12 PM
> > > To: Hiremath, Vaibhav
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
> > >
> > > On Mon, 2010-03-22 at 14:09 +0100, ext hvaibhav@ti.com wrote:
> > > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > >
> > > > In case of 720P with 90/270 degree rotation, the system reports
> > > > GFX_FIFO_UNDERFLOW error which usually happens if DSS DMA is not able
> to
> > > fill
> > > > the FIFO as per requirement.
> > > >
> > > > In TRM (section 11.2.6.1.3), where is has been clearly mentioned that,
> > > >
> > > > "To improve the performance on 90 degree rotation, split the data
> access
> > > on
> > > > write side and not read side."
> > > >
> > > > That means, read should always happen on 0 degree and write should go
> to
> > > > respective rotation view.
> > >
> > > I haven't had time to look at this patch yet. I'll try to do it next
> > > week.
> > [Hiremath, Vaibhav] Tomi,
> >
> > Have you had a chance to look at this patch/issue?
> 
> Sorry, no I haven't. It's on my list. But did you consider my
> explanation? Does your implementation support changing the rotation
> dynamically?
[Hiremath, Vaibhav] Yes, I have validated it here at my end for some rotation angles. Just to clarify more on this, below is the test environment -

	- Enable the rotation through bootargs,

Bootargs: omapfb.rotate=1 omapfb.rotate_type=y vram=10M vram.fb=0:10

	- Boot the system and configure the rotation using FBIOPUT_VSCREENINFO by using var.rotate field.

	- Normal test case which I run -

Var.rotate = 0	(0 degree)
Var.rotate = 1	(90 degree)

Thanks,
Vaibhav

> 
>  Tomi
> 

