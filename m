From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2 v2] ARM: DRA7/335x/437x/OMAP4: hwmod: Remove elm
 address space from hwmod data
Date: Mon, 26 Oct 2015 17:06:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1510261700320.17863@utopia.booyaka.com>
References: <1444926461-16092-1-git-send-email-fcooper@ti.com> <alpine.DEB.2.02.1510231858170.9575@utopia.booyaka.com> <562E3DA8.4000006@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562E3DA8.4000006@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, rogerq@ti.com, nm@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Franklin,

On Mon, 26 Oct 2015, Franklin S Cooper Jr. wrote:

> On 10/23/2015 02:00 PM, Paul Walmsley wrote:
> > On Thu, 15 Oct 2015, Franklin S Cooper Jr wrote:
> >
> >> ELM address information is provided by device tree. No longer need
> >> to include this information within hwmod.
> >>
> >> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> > The OMAP4 DTS files don't have the ELM address space declared.  I'm going 
> > to drop that portion of your patch.  Could you please send a two-patch 
> > series that first adds the ELM address space to the OMAP4 DTS file and 
> > then subsequently drops it from the OMAP4 hwmod data file?
> Hi Paul,
> 
> Sorry about that. I can create the patches but I don't see any board omap4
> board that has nand support. So I'm not going to be able to test to insure if
> omap_elm.c will work as is.
> 
> Should I just drop omap4 from this patchset or should I just add the elm node
> to omap4.dtsi and if people report an issue with omap_elm then we can fix it?

Please write the OMAP4 patches since we're trying to get the data cleaned 
up.  You don't need to worry about the DRA7/335x/437x platforms; those 
patches have already been merged.  The ELM hwmod should be initialized 
even on boards without NAND, so that should be a reasonable test of the 
register address space, at least.  Please note in the patch description 
whether your patches are untested, tested just to initialize/boot, or 
whether they've been tested on an active NAND flash workload.

thanks

- Paul
