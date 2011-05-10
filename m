From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Tue, 10 May 2011 15:30:52 +0300
Message-ID: <1305030652.2045.49.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com> <1304595408.30935.16.camel@deskari>
	 <20110505130204.GK11744@opensource.wolfsonmicro.com>
	 <1304955274.2215.26.camel@deskari>
	 <20110509191912.GA6546@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52331 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755434Ab1EJMa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 08:30:57 -0400
Received: by mail-ew0-f49.google.com with SMTP id 3so2033028ewy.36
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 05:30:56 -0700 (PDT)
In-Reply-To: <20110509191912.GA6546@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Mon, 2011-05-09 at 21:19 +0200, Mark Brown wrote:
> On Mon, May 09, 2011 at 06:34:34PM +0300, Tomi Valkeinen wrote:

> > The second thing is that even if the power source for vdds_dsi may be
> > configured differently on different boards, the same vdds_dsi goes to
> > multiple DSS HW blocks inside OMAP, each represented by a separate
> > omap_device. So it'd be much nicer to configure just the vdds_dsi power
> > in the board file, but let the omap display code configure the
> > regulators properly for all the DSS HW blocks in that particular OMAP.
> 
> For this I'd suggest setting up an arrangement with supplies where you
> have one thing on the OMAP is supplied by board configuration and then
> it has child supplies within the device but right now that's not so easy
> to do.  I was just writing some stuff for that this afternoon but it'll
> be next week before I can test it properly.

This sounds just the thing we need here. Do you think there's a chance
the code could get merged in the next window? And I'm also happy to test
the code with omapdss, whenever you have something ready.

I think we'll go forward with this patch set in a modified form: we'll
leave the board files untouched and add the DSS driver parts (which is
99% of the patch set) with a small hack which makes things work with the
current device setup.

This means we won't be able to use the second DSI LCD yet, but getting
the biggest bulk of code in is more important.

 Tomi


