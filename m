From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: Remove elm address space from hwmod
 data
Date: Thu, 15 Oct 2015 06:25:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1510150625290.22383@utopia.booyaka.com>
References: <1444743874-4454-1-git-send-email-fcooper@ti.com> <561DFD26.9090702@ti.com> <561E53EB.9060207@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561E53EB.9060207@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, 14 Oct 2015, Franklin S Cooper Jr. wrote:

> 
> 
> On 10/14/2015 01:58 AM, Roger Quadros wrote:
> > On 13/10/15 16:44, Franklin S Cooper Jr wrote:
> >> ELM address information is provided by device tree. No longer need
> >> to include this information within hwmod.
> >>
> >> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> > Acked-by: Roger Quadros <rogerq@ti.com>
> >
> > Franklin,
> >
> > Can you please do the same for gpmc_addr as well?
> >
> > And looks like elm_addr needs to be removed from
> > omap_hwmod_33xx_43xx_interconnect_data.c and omap_hwmod_44xx_data.c as well, no?
> Sure I'll combine the 335x and 44x elm removal with this patch and then create a separate patch for the gpmc version.

OK, holding off on this until you update the patch.


- Paul
