From: Marin Mitov <mitov@issp.bas.bg>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Thu, 19 Aug 2010 15:16:21 +0300
Message-ID: <201008191516.21910.mitov@issp.bas.bg>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <201008191308.07336.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1008191336290.26145@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1008191336290.26145@axis700.grange>
Sender: linux-media-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

On Thursday, August 19, 2010 02:39:47 pm Guennadi Liakhovetski wrote:
> On Thu, 19 Aug 2010, Janusz Krzysztofik wrote:
> 
> > Hi Marin,
> > Since I've finaly managed to make use of your method without any previously 
> > observerd limitations (see below), I'm interested in it being implemented 
> > system-wide. Are you going to submit a patch?

It is ready, I just wait for the invitation.

Marin Mitov

> 
> I'm about to submit a patch, which you'll be most welcome to test. Just 
> give me a couple more hours.
> 
> > I would suggest creating one common function that allocates and fills the 
> > dev->dma_mem structure, and two wrappers that call it: a 
> > dma_declare_coherent_memory() replacement, that passes an ioremapped device 
> > memory address to the common fuction, and your proposed 
> > dma_reserve_coherent_memory(), that passes a pointer returned by the 
> > dma_alloc_coherent() instead.

> No, I don't think you should go to the next power of 2 - that's too crude. 
> Try rounding your buffer size to the page size, that should suffice.

Allocated coherent memory is always a power of 2.
Thanks.

Marin Mitov

> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
