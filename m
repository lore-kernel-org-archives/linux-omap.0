From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending patches, was: Git tree updated to 2.6.23-rc2
Date: Mon, 13 Aug 2007 02:06:23 -0700
Message-ID: <20070813090623.GK13948@atomide.com>
References: <20070806125225.GA2312@atomide.com> <46BCB2BD.1090905@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429019C4F78@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429019C4F78@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070810 13:16]:
> > Can you undo this 1/3 nand patch?  2430 doesn't build without the other
> > 2 patches due to some missing header (asm/arch/nand.h) that come with
> > the later patches.
> 
> Kevin for compiles sake I added the missing patches instead of removing.

I reverted the 1/3 nand patch, and applied Richard's two fixes.
I'll take a closer look at the nand patch this week, let's try to
get things working for 2430 soon.

> There were a couple more fixes which I also added to get it booting.
> 	- update defconfig to have vfp
> 	- add missing TWL patch

I did not see a TWL patch in your attached patch?

> 	- add in micron path
> 	- fix clock build error
> 	- turn back on by default omap_clocks (we use this at run time)
> 
> Strongly, the MPU is starting at 165MHz instead of 330...  Some new bug I suppose.

Regards,

Tony
