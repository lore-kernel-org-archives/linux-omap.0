From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 0/2] OMAP1: amsdelta: reserve memory for videobuf_contig
Date: Fri, 10 Dec 2010 11:47:03 +0100
Message-ID: <201012101147.04868.jkrzyszt@tis.icnet.pl>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl> <20101210012908.GQ3054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20101210012908.GQ3054@atomide.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-omap@vger.kernel.org

Friday 10 December 2010 02:29:09 Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101205 10:19]:
> > Latest developements seem to allow for reserving a block of memory on
> > boot to be used as a device dedicated dma coherent memory. This may be
> > required for videobuf_config based video drivers avoid problems with
> > allocating dma coherent memory after system memory gets fragmented.
> >
> > This set extends the OMAP1 camera resource initialization code with a
> > function that can be used for reserving a block of memory early, then
> > declared as the camera device dedicated dma coherent memory.
> >
> > An example use case is provided for Amstrad Delta camera.
>
> These look good to me, however, can you please also Cc linux-arm-kernel
> list as otherwise I will need to repost these before merging.

Sure. Perhaps that first submission should rather go as an RFC, now that there 
are no requests for changes, I'll repost with Cc linux-arm-kernel.

Thanks,
Janusz
