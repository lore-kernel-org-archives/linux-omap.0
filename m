From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: linux-next: manual merge of the omap_dss2 tree with the omap
 tree
Date: Wed, 12 May 2010 11:59:04 +0300
Message-ID: <1273654744.2814.14.camel@tubuntu.research.nokia.com>
References: <20100507134334.75808884.sfr@canb.auug.org.au>
	 <20100510202056.GG16460@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100510202056.GG16460@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, 2010-05-10 at 22:20 +0200, ext Tony Lindgren wrote:
> * Stephen Rothwell <sfr@canb.auug.org.au> [100506 22:05]:
> > Hi Tomi,
> > 
> > Today's linux-next merge of the omap_dss2 tree got a conflict in
> > arch/arm/mach-omap2/board-rx51-peripherals.c between commit
> > e87da74e34ad151e6ae75ebb7a7bf447f02c0004 ("omap: rx51: Add supplies for
> > the tlv320aic3x codec driver") from the omap tree and commit
> > a693839eab0292aa234d7a6f48d40389389baebb ("OMAP: RX51: Add "vdds_sdi"
> > supply voltage for SDI") from the omap_dss2 tree.
> > 
> > Just overlapping additions. I fixed it up (see below) and can carry the
> > fix as necessary.
> 
> Thanks again Stephen. We will move the conflicting DSS board-*.c
> file changes over to omap for next.
> 
> Tomi, do you want to do a branch of board-*.c patches for me to
> pull, or do you want me to just pick this one?

I think it's ok to pick just this one. It's just adds a regulator
supply, and doesn't interfere with anything. I just need to make sure
linux-omap's for-next is merged first, before I send my pull request.

I made a branch for it, based on linux-omap/for-next:
git://gitorious.org/linux-omap-dss2/linux.git for-tony

And I dropped the patch from my for-next branch.

 Tomi
