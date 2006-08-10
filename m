From: Tony Lindgren <tony@atomide.com>
Subject: Re: old gpmc.h
Date: Thu, 10 Aug 2006 13:43:51 +0300
Message-ID: <20060810104350.GE30195@atomide.com>
References: <20060808103503.98907.qmail@web37901.mail.mud.yahoo.com>
	<20060810095401.GD30195@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060810095401.GD30195@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [060810 12:54]:
> * Komal Shah <komal_shah802003@yahoo.com> [060808 13:35]:
> > Tony,
> > 
> > It seems that gpmc.h is not updated after Imre patch about dynamic
> > allocator for GPMC. It gives me following error for h4 build.
> > 
> > arch/arm/mach-omap2/built-in.o(.init.text+0xae4): In function `$a':
> > : undefined reference to `gpmc_cs_request'
> > arch/arm/mach-omap2/built-in.o(.init.text+0xb48): In function `$a':
> > : undefined reference to `gpmc_cs_free'
> > arch/arm/mach-omap2/built-in.o(.init.text+0xb68): In function `$a':
> > : undefined reference to `gpmc_cs_request'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > Please update gpmc.h as per Imre's patch. Thanx.
> 
> Weird looks like some merges from 2.6.17-omap2 did not happen. It is
> there as a7abfb3157101ee90f45e261c64850c980d1b6dc, but not in the
> current head. There's probably other stuff unmerged as well then.
> I'll try to fix it.

I found following two commits that had just disappeared after
2.6.17-omap2:

$ git-cherry-pick afffc24530956387faa51a42a1e5a4eee344d4a1
First trying simple merge strategy to cherry-pick.
Simple cherry-pick fails; trying Automatic cherry-pick.
Auto-merging arch/arm/mach-omap2/board-apollon.c
Auto-merging arch/arm/mach-omap2/gpmc.c
Auto-merging include/asm-arm/arch-omap/gpmc.h
Finished one cherry-pick.

$ git-cherry-pick 64929d882591a213cb51407992f28c42121b2f7d
First trying simple merge strategy to cherry-pick.
Simple cherry-pick fails; trying Automatic cherry-pick.
Auto-merging arch/arm/plat-omap/clock.c
Auto-merging include/asm-arm/arch-omap/clock.h
Finished one cherry-pick.

No idea how that happens, maybe problems with some versions of git?

Tony
