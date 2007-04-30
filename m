From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Mon, 30 Apr 2007 15:34:02 -0700
Message-ID: <1177972442.32350.9.camel@paris.hilman.org>
References: <20070321004030.424076000@mvista.com>
	<20070426173507.GB9764@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-sSRT4Qcq8MNqzD+wOgTg"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070426173507.GB9764@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--=-sSRT4Qcq8MNqzD+wOgTg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-04-26 at 17:35 +0000, Tony Lindgren wrote:
> * Kevin Hilman <khilman@mvista.com> [070321 00:49]:
> > Adds platform device for use of existing OMAP2 driver.  Also, the
> > following changes are made to the existing driver:
> > 
> > - add option for not using DMA (by passing dma_channel = -1)
> > - removes obsoleted pt_regs arg from interrupt handler
> > 
> > RFC: Notice the change to onenand_base.c which comments out the last
> >      OOB chunk.  Without this, it would not work.  Previous drivers
> >      for this board such as the 2.6.10-based MV kernel have this
> >      same change.  Anyone know what is going on here?
> 
> Can you please refresh this one and split it into two patches:
> 
> >  arch/arm/mach-omap2/Makefile              |    3 
> >  arch/arm/mach-omap2/board-2430sdp-flash.c |  108 ++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/board-2430sdp.c       |    4 +
> >  arch/arm/mach-omap2/gpmc.c                |    1 
> >  include/asm-arm/arch-omap/gpmc.h          |    7 +
> >  include/asm-arm/arch-omap/onenand.h       |    1 
> 
> The above could be one patch ready for omap-upstream queue.
> 
> >  drivers/mtd/onenand/omap2.c               |  103 +++++++++++++++++-----------
> >  drivers/mtd/onenand/onenand_base.c        |    2 
> 
> This should be separate and sent to MTD list.

Kyungmin,

What's the status of the patch you submitted to the MTD list for this
fix?

FWIW, attached is a patch which fixes the walking of the ooblist, as
well as an update to the omap2 driver for the non-DMA case.

Kevin


--=-sSRT4Qcq8MNqzD+wOgTg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-sSRT4Qcq8MNqzD+wOgTg--
