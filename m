From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
Date: Thu, 12 May 2011 20:20:44 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DBC1686@dbde02.ent.ti.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304926567-26814-5-git-send-email-tomi.valkeinen@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC0C34@dbde02.ent.ti.com>
	 <1305095563.2097.11.camel@deskari> <4DCB80DD.5090408@compulab.co.il>
	 <4DCB8937.2060101@compulab.co.il> <4DCB9C71.2020503@compulab.co.il>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC13C0@dbde02.ent.ti.com>
	 <4DCBC273.9030807@compulab.co.il> <1305200857.2062.24.camel@deskari>
	 <EAF47CD23C76F840A9E7FCE10091EFAB033DBC1679@dbde02.ent.ti.com>
 <1305211624.2062.62.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44673 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab1ELOu5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 10:50:57 -0400
In-Reply-To: <1305211624.2062.62.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Stanley Miao <stanley.miao@windriver.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Thursday, May 12, 2011 8:17 PM
> To: Janorkar, Mayuresh
> Cc: Igor Grinberg; linux-omap@vger.kernel.org; Stanley Miao
> Subject: RE: [PATCH 4/6] OMAP: LDP: Port the display driver to new DSS2
> 
> On Thu, 2011-05-12 at 20:06 +0530, Janorkar, Mayuresh wrote:
> > > -----Original Message-----
> > > From: Valkeinen, Tomi
> > > Sent: Thursday, May 12, 2011 5:18 PM
> > > To: Igor Grinberg
> > > Cc: Janorkar, Mayuresh; tony@atomide.com; linux-omap@vger.kernel.org;
> > > Stanley Miao
> > > Subject: Re: [PATCH 4/6] OMAP: LDP: Port the display driver to new
> DSS2
> > >
> > > On Thu, 2011-05-12 at 14:20 +0300, Igor Grinberg wrote:
> > >
> > > > Right. Do both fixes make it work?
> > > >
> > > > If it is, then Tomi,
> > > > will you add both fixes to the patch set with our SOBs?
> > > > or do you want this to be sent properly as a follow up?
> > >
> > > Yes, I can add these all to the same patch and handle it through DSS
> > > tree. Although due to the reluctance to make changes to
> arch/arm/*omap*,
> > > I guess we'll pass these patches in this merge window.
> > >
> > > Mayuresh, if you're able to test this and it works, can you send me
> the
> > > full diff so that I don't make any mistakes combining the code?
> > >
> > >  Tomi
> > >
> >
> > Please find the patch below.
> > I have also attached the same.
> >
> > There are formatting problems with this patch. But this can be used as a
> reference.
> >
> > I have verified bootup with Penguins on LDP board.
> 
> Why did you create a new panel for LDP? The generic panel driver should
> handle it well enough.
> 
> The attached panel driver is also quite messed up. It does things that
> belong to the board file, and the timings are a bit high, giving refresh
> rate of 120MHz. Does LDP have a 120MHz panel?

You can use that code as reference and not as a patch.
Please take a look at changes in board file.
There is no need to create a new panel. It can be added as a part of generic panel.

I have taken timings info from: drivers/video/omap/lcd_ldp.c

#ifdef CONFIG_FB_OMAP_LCD_VGA
#define LCD_XRES                480
#define LCD_YRES                640
#define LCD_PIXCLOCK_MAX        41700
#else
#define LCD_XRES                240
#define LCD_YRES                320
#define LCD_PIXCLOCK_MAX        185186
#endif


> 
>  Tomi
> 

