From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/3] Add ioremap_exec and extend drivers/misc/sram.c
Date: Thu, 12 May 2016 09:30:34 -0700
Message-ID: <20160512163033.GP5995@atomide.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [160509 14:44]:
> Hi,
> There are several instances when one would want to execute out of on-chip
> SRAM, such as PM code on ARM platforms, so once again revisiting this
> series to allow that. Seems that having a solution for allowing SRAM to be
> mapped as executable will help clean up PM code on several ARM platforms and
> also open the door for others like TI AM335x and AM437x. This was first sent
> here [1] but this is rebased and updated for v4.6-rc.
> 
> Many platforms have migrated to using the generic SRAM driver at
> drivers/misc/sram.c but it doesn't seem like there is a clean solution
> for the common problem of needing to map executable pages.
> 
> Currently I see several platforms (at-91, imx6, socfpga) taking the
> address allocated by the genpool given by the SRAM driver and then calling
> __arm_ioremap_exec on it again to get a new address that can be executed.
> This doesn't seem like the cleanest solution, but maybe it works for code
> that is under mach-xxx but what about code that migrates outside into the
> drivers layer? Do any other architectures have a requirement for this?
> 
> I've converted omap3 PM code to use the generic SRAM driver which I'll send
> in a series right after this one, and AM335x and AM437x can both make use of
> this series as well and even go as far as to move a chunk of the PM
> code into drivers (needs to be updated but sent long ago here [2]), but
> that will be blocked if we don't have a generic way to ioremap memory as
> exec, or at least a way to do it from drivers/.
> 
> If we don't want to go down this path, is there a better idea for how to
> call ioremap_exec from drivers/ that we can all agree on?

Looks to me that this should allow moving the current SRAM code
into drivers. So feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
