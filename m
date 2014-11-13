From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Thu, 13 Nov 2014 09:54:14 -0800
Message-ID: <20141113175414.GP26481@atomide.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com>
 <20141106180333.GZ31454@atomide.com>
 <545C9267.7060301@ti.com>
 <545C97AB.4040402@ti.com>
 <20141107224832.GG31454@atomide.com>
 <545FC08D.8000008@pek-sem.com>
 <20141112180253.GJ26481@atomide.com>
 <54649612.8090402@ti.com>
 <5464D5AD.30508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5464D5AD.30508@ti.com>
Sender: stable-owner@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, pekon <pekon@pek-sem.com>, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tom Rini <trini@ti.com> [141113 08:02]:
> On 11/13/2014 06:29 AM, Roger Quadros wrote:
> > On 11/12/2014 08:02 PM, Tony Lindgren wrote:
> >>
> >> Right no objections to using BCH8 for rootfs, except it stopped working
> >> over past year or so.
> > 
> > This would be BCH8-sw on OMAP3 right? AM3xx uses BCH8-hw and that seems to work fine.
> > So it seems nobody has used/tested BCH8-sw.
> 
> A few years back, and I want to choose my words carefully when talking
> about error correction, BCH8-sw was "working" well enough for rootfs (I
> didn't induce any particular amount of errors or try and cause corner
> cases, etc, etc).

Yes it still works, but for LDP it broke because of the regression
discussed in $thread.
 
> >> And it seems the settings should be partition specific because of u-boot
> >> requiring HAM1.
> >>
> > I don't think we have partition specific ECC scheme support in u-boot or kernel,
> > so it will become messy to manage.
> > That means we either stick with HAM1 for all partitions or don't support NAND boot
> > at all and go with any other ECC scheme for OMAP3.
> 
> This is indeed where life starts getting more complicated than what we
> allow for today in both U-Boot and Kernel, as I recall things anyhow.  I
> think omap3 does (and I know am335x and later do) allow for saying ECC
> is all done on-chip and ROM should do nothing.  But if you want to boot
> you're going to be limited to HAM1 (or in some cases BCH4?  I didn't
> have to deal with these parts myself so second-hand recollections here)
> if you want to _boot_.  So you'll be in that particular area of the part
> life-span where you have to worry about read disturbances and so forth.
> 
> We _really_ do need (in both kernel and U-Boot) the ability to say a
> "partition" has ECC scheme X and another has scheme Y due to limitations
> on what you can boot from vs what you need for the (continued) life span
> of the device in question.

Totally. Updating the bootloader should be doable safely from userspace
after booting the kernel. Or else should disable those partitions for
kernel because people are trashing their u-boot while trying to update.

Regards,

Tony
