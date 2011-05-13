From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2: Simultaneous DSI and DPI panels
Date: Fri, 13 May 2011 14:18:53 +0300
Message-ID: <1305285533.2268.41.camel@deskari>
References: <BANLkTi=1XZyu6hQq7RLxcjQ0WZ8neGbNcQ@mail.gmail.com>
	 <4DCD0BA4.2050904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46277 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932213Ab1EMLS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 07:18:57 -0400
Received: by mail-ew0-f42.google.com with SMTP id 2so902480ewy.15
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 04:18:56 -0700 (PDT)
In-Reply-To: <4DCD0BA4.2050904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Juha Kuikka <juha.kuikka@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Fri, 2011-05-13 at 16:14 +0530, Archit Taneja wrote:
> Hi,
> 
> On Friday 13 May 2011 12:46 AM, Juha Kuikka wrote:
> > Hello,
> >
> > I was wondering if it would be possible to run DPI and DSI interfaces
> > simultaneously with OMAP3 (DM3730).
> >
> > Limitations:
> > - DSI would have to be in video mode (data to DSI phy through video
> > port with H/VSYNC signaling, OMAP_DSS_PARALLELMODE_BYPASS)
> > - DSI PLL would need to be used for clock source
> > - Both the DPI and DSI panels would have to accept identical clocking
> > (PCLK, blanking intervals etc).
> > - Data lane # must match.
> > - And of course same data would go to both
> >
> > I realize the current SW does not support this, but I'm more wondering
> > if it is possible from the HW point of view because it seems to me
> > that data out from DISPC is pretty much identical in both cases.
> 
> I don't think this is possible on OMAP3, there is one LCD manager in 
> OMAP3 which can either feed pixels to DPI or DSI.
> 
> The only way you could run 2 panels is by routing LCD manager's content 
> to DPI, and use DSI's capability to do a system DMA directly and send 
> the data to the panel(bypassing DISPC), I don't think the system DMA 
> method will work with a video mode panel, only command mode panels will 
> do here.

Yes, that is correct. DPI + DSI command mode would work, although in
that case the DSI panel would be driven by CPU or sDMA, both of which
are not very good at the job.

 Tomi


