From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: manual merge of the omap_dss2 tree with the omap
 tree
Date: Mon, 10 May 2010 13:20:56 -0700
Message-ID: <20100510202056.GG16460@atomide.com>
References: <20100507134334.75808884.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100507134334.75808884.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <roger.quadros@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [100506 22:05]:
> Hi Tomi,
> 
> Today's linux-next merge of the omap_dss2 tree got a conflict in
> arch/arm/mach-omap2/board-rx51-peripherals.c between commit
> e87da74e34ad151e6ae75ebb7a7bf447f02c0004 ("omap: rx51: Add supplies for
> the tlv320aic3x codec driver") from the omap tree and commit
> a693839eab0292aa234d7a6f48d40389389baebb ("OMAP: RX51: Add "vdds_sdi"
> supply voltage for SDI") from the omap_dss2 tree.
> 
> Just overlapping additions. I fixed it up (see below) and can carry the
> fix as necessary.

Thanks again Stephen. We will move the conflicting DSS board-*.c
file changes over to omap for next.

Tomi, do you want to do a branch of board-*.c patches for me to
pull, or do you want me to just pick this one?

Regards,

Tony
