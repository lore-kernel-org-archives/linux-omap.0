From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending patches, was: Git tree updated to 2.6.23-rc2
Date: Fri, 10 Aug 2007 00:08:03 -0700
Message-ID: <20070810070802.GC8658@atomide.com>
References: <46B73C93.5090202@googlemail.com>
	<9C23CDD79DA20A479D4615857B2E2C47017EF86F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47017EF86F@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Syed Mohammed, Khasim <x0khasim@ti.com> [070806 16:29]:
> 
> >
> >Tony Lindgren wrote:
> >> I've just updated our git tree to 2.6.23-rc2.
> >
> >:)  Thanks!
> >
> >> There are quite a few pending patches, I will be looking at them
> >> this week.
> >
> >25. [PATCH] Enable Kernel based uncompressing for OMAP3
> >
> 
> This patch is not required.
> 
> There were few more patches from Kevin Hilman and me on TWL4030 I don't see them in list. 

I only found this:

Jul 25 Syed Mohammed,  (  71)  [PATCH] To Cleanup TWL-Core driver

Any other patches?

> I just validated 2430 and 3430 booting with this merge both seems to work as expected - thanks Tony.

Great, can you please diff the ARMv7 patches against the mainline? I
left some of that out and you may want to manually merge some of the
code back. Or maybe they are not needed any longer?

Anyways, those changes should be discussed on linux-arm-kernel list.

> What is the time line we should be expecting for OMAP1/2 patches to be merged to mainline? Like 23 RC-?? 

Hopefully we'll get most of the patch pile merged for 2.6.24. I'll redo
our pending patches trying to collapse some of them in order to have
fewer patches.

> Was curious why is OMAP patches taking so long? They were submitted months back. Where as FB and SPI went into main line with in few days ... :(

Russell does not have enough time to review the patches, and there
are lots of patches. But we'll get them integrated eventually :)

Regards,

Tony
