From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: hide omap3_save_secure_ram on non-OMAP3
 builds
Date: Wed, 6 Dec 2017 14:04:05 -0800
Message-ID: <20171206220405.GZ28152@atomide.com>
References: <20171206141517.670032-1-arnd@arndb.de>
 <20171206155714.GY28152@atomide.com>
 <a055eca0-fa24-a04a-7278-f633a12e6bae@ti.com>
 <CAK8P3a13Or8OvttqiKo8Qg2q6UJwQPg0E5TGb02LUb+p8nB3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a13Or8OvttqiKo8Qg2q6UJwQPg0E5TGb02LUb+p8nB3kw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Murphy <dmurphy@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [171206 21:51]:
> On Wed, Dec 6, 2017 at 5:29 PM, Dan Murphy <dmurphy@ti.com> wrote:
> > Arnd
> >
> > On 12/06/2017 09:57 AM, Tony Lindgren wrote:
> >> * Arnd Bergmann <arnd@arndb.de> [171206 14:18]:
> >>> In configurations without CONFIG_OMAP3 but with secure RAM support,
> >>> we now run into a link failure:
> >>>
> >>> arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
> >>> omap-secure.c:(.text+0x130): undefined reference to `save_secure_ram_context'
> >>>
> >>> The omap3_save_secure_ram() function is only called from the OMAP34xx
> >>> power management code, so we can simply hide that function in the
> >>> appropriate #ifdef.
> >>>
> >>> Fixes: d09220a887f7 ("ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context")
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Thanks for fixing it, want to apply directly to ARM SoC fixes
> >> where d09220a887f7 is now? If so:
> >>
> >> Acked-by: Tony Lindgren <tony@atomide.com>
> >
> > Found the same issue in our builds.
> > Compile tested the patch against different TI defconfig configurations.
> >
> > Tested-by: Dan Murphy <dmurphy@ti.com>
> 
> Thanks!
> 
> Unfortunately, I found another build problem with CONFIG_PM=n,
> sent an updated patch now, and will apply it to the fixes branch
> tomorrow keeping both of your Acked-by/Tested-by tags, unless
> I hear any objections or run into a third problem.

OK thanks works for me.

Tony
