From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending March patches
Date: Tue, 3 Apr 2007 15:30:50 -0400
Message-ID: <20070403193046.GA24864@atomide.com>
References: <460FD29D.7070707@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <460FD29D.7070707@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Thanks again for the list, here are some comments on the status.

* Dirk Behme <dirk.behme@googlemail.com> [070401 11:43]:
> 
> Please find below my list of pending OMAP patches for March 
> 2007. As ususal, if you think anything is wrong, missing or 
> already applied, please correct.
> 
> 
> Pending OMAP patches March 2007
> -------------------------------
> 
> 1. [PATCH] Display Controller Library for OMAP2420/2430/3430 
> platforms.
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009182.html

This is still pending comments from Imre, and possibly regarding V4L
from Mauro.

> 2. [PATCH] add ssi/Kconfig to arch/arm/Kconfig
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009220.html

I already nuked the drivers/ssi :)

> 2. [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009290.html

Carlos should test this on various boards.

> 3. [PATCH 1/1] OMAP: Add TWL support for omap mmu framework
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009313.html

Being reworked as mentioned by Hiroshi.

> 4. [PATCH 1/2] ARM:OMAP: Integrated blk request queues for 
> mbox fwk
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009355.html

Should be applied already in master branch, but probably buried under
other changes. Hiroshi, can you please verify?

> 5. [PATCH 2/2] ARM: OMAP: Restructuring mailbox blk queues
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009356.html

Should be applied already, Hiroshi, can you verify?

> 6. [PATCH 1/2] OMAP: DSP: N800: remaining updates for dsp parts
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009359.html

Should be applied already, Hiroshi, can you verify?

> 7. [PATCH 2/2] OMAP: MBOX: N800: remaining updates for 
> mailbox parts
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009358.html

Should be applied already, Hiroshi, can you verify?

> 8. [PATCH] ARM: OMAP: Fix warnings in devices.c for 2430sdp 
> config
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009380.html
> 
> 9. [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009386.html

Pushing today.

> "Dave, can you have a look" patches ;)
> --------------------------------------
> 
> 1. [review] OMAP2 USB device DMA support
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008342.html
> 
> 2. [PATCH] MUSB HDRC: RMMOD fixing
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008853.html

Regards,

Tony
