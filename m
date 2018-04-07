From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [BUG] Fix drivers/memory O= build
Date: Sat, 7 Apr 2018 14:38:17 +0100
Message-ID: <20180407133817.GE10990@n2100.armlinux.org.uk>
References: <20180406102519.GN16141@n2100.armlinux.org.uk>
 <20180406164615.GL5700@atomide.com>
 <06568f5b-3e4a-f761-7242-85dcc8aeb6a5@oracle.com>
 <20180406185505.GD10990@n2100.armlinux.org.uk>
 <CAK7LNARbST+-oy-J9B2Q2vSp0nhnn9gqOnT7urZdjQZhSpYB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNARbST+-oy-J9B2Q2vSp0nhnn9gqOnT7urZdjQZhSpYB-Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>, arm-soc@armlinux.org.uk, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Dave Gerlach <d-gerlach@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 07, 2018 at 11:55:22AM +0900, Masahiro Yamada wrote:
> 2018-04-07 3:55 GMT+09:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> > On Fri, Apr 06, 2018 at 11:45:01AM -0700, Santosh Shilimkar wrote:
> >> On 4/6/2018 9:46 AM, Tony Lindgren wrote:
> >> >* Russell King - ARM Linux <linux@armlinux.org.uk> [180406 03:27]:
> >> >>When building a kernel with split object directories, the following
> >> >>failure occurs:
> >> >>
> >> >>.../drivers/memory/emif-asm-offsets.c:1:0: fatal error: can't open drivers/memory/emif-asm-offsets.s for writing: No such file or directory
> >> >>compilation terminated.
> >> >>drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
> >> >>make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
> >> >>.../Makefile:1060: recipe for target 'arch/arm/mach-omap2' failed
> >> >>make[1]: *** [arch/arm/mach-omap2] Error 2
> >> >>
> >> >>This prevents any kernel being built that includes decending into
> >> >>arch/arm/mach-omap2 with split object directories.
> >> >>
> >> >>This is a regression.
> >> >
> >> >Dave, I presume you're looking into this already?
> >> >
> >> Fix is already posted by 'Anders Roxell <anders.roxell@linaro.org>'
> >> You are copied on the email Tony.
> >
> > Arnd also has a fix for it as well, which moves emif-asm-offsets.s
> > into include/generated, as that will always exist prior to these
> > rules being invoked.  Arnd's passing it through his randconfig
> > builder before publishing it.
> 
> 
> I do not like this idea.
> 
> Not sure exactly what Arnd is trying to do,
> but the same file should not be touched from multiple points
> in case Kbuild descends into mach-omap2/ and memory/ at the same time.
> 
> 
> I recommend to put copies in each directory:
> 
> arch/arm/mach-omap2/emif-asm-offsets.h
> drivers/memory/ti-emif-asm-offsets.h
> 
> 
> If you want me to send a patch,
> I will give it a try.

Or we try and find another way around this.

The original idea was to start throwing platform specific (iow, stuff in
arch/arm/mach-omap2/) includes into arch/arm/kernel/asm-offsets.c.  I
objected to that, and suggested that the generic infrastructure for doing
the asm-offsets thing should be used to generate an architecture specific
header.

Then it turns out that files in both arch/arm/mach-omap2 and drivers/memory
need these constants, and TI proposed the existing method.

Obviously, all the right people reviewed it and approved it, which is why
it's now in mainline, but unfortunately it doesn't actually work, and
breaks my kernel builds!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
