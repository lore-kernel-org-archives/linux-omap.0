From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] musb_hdrc: Unify naming and rename common files
Date: Tue, 21 Aug 2007 00:23:28 -0700
Message-ID: <20070821072328.GG31816@atomide.com>
References: <11876010273160-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11876010273160-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [070820 06:38]:
> Hi all,
> 
> Attached patch series replaces Inventra naming with
> musb, and renames the core musb files to start with
> musb_.
> 
> Renaming the files unifies the file names, and groups
> them by type. This all should make it easier for people
> to locate the right piece of code within the driver.
> 
> After applying the patch series, the musb directory
> has following files:
> 
> $ ls
> cppi_dma.c   musb_core.c        musb_host.c          omap2430.h
> cppi_dma.h   musb_core.h        musb_host.h          tusb6010.c
> davinci.c    musb_debug.h       musb_host_virthub.c  tusb6010.h
> davinci.h    musb_dma.h         musbhsdma.c          tusb6010_omap.c
> Kconfig      musb_gadget.c      musb_procfs.c
> Makefile     musb_gadget_ep0.c  musb_regs.h
> musb_arch.h  musb_gadget.h      omap2430.c
> 
> Tested on tusb.

Pushing this series today refreshed based on following comments
from David Brownell:

- 1/9: Use MUSB_PIO_ONLY instead of USB_MUSB_DISABLE_DMA, fix
  Makefile comment
  
- 3/9: Use musb_io.h instead of musb_arch.h

- 8/9: Use musb_virthub.c instead of musb_host_virthub.c

Regards,

Tony
