From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
Date: Fri, 8 Mar 2013 08:35:07 -0800
Message-ID: <20130308163507.GC26093@atomide.com>
References: <1362738596.5994.48.camel@x61.thuisdomein>
 <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130308161159.GE14552@blackmetal.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Paul Bolle <pebolle@tiscali.nl>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130308 08:16]:
> On Fri, Mar 08, 2013 at 11:29:56AM +0100, Paul Bolle wrote:
> > When support was added for Nokia N9 (RM-696), with commit
> > 63fc5f3bb3d0ca9ab4767a801b518aa6335f87ad ("ARM: OMAP: add minimal
> > support for Nokia RM-696"), a select statement for MACH_NOKIA_RM696 was
> > added to the tree. But there's no Kconfig symbol with that name. That
> > symbol would be superfluous, since support for that machine piggybacks
> > on MACH_NOKIA_RM680. So drop that select.
> 
> This is needed because of arch/arm/tools/mach-types. See
> include/generated/mach-types.h.
> 
> If you have just CONFIG_MACH_NOKIA_RM680 and run the kernel on RM-696,
> then machine_is_nokia_rm696() will return false. If I rememeber correctly,
> this broke at least early printk / uncompressor output at the time.
> 
> I guess people may still want to use machine_is_... macros e.g. for
> debugging.

I think the righ fix is to just add

config MACH_NOKIA_RM680
	bool

to the mach-omap2/Kconfig like we have for n8x0 also.

Regards,

Tony
