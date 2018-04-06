From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] Fix drivers/memory O= build
Date: Fri, 6 Apr 2018 09:46:15 -0700
Message-ID: <20180406164615.GL5700@atomide.com>
References: <20180406102519.GN16141@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180406102519.GN16141@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Michal Marek <michal.lkml@markovi.net>, arm-soc@armlinux.org.uk, linux-kbuild@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180406 03:27]:
> When building a kernel with split object directories, the following
> failure occurs:
> 
> .../drivers/memory/emif-asm-offsets.c:1:0: fatal error: can't open drivers/memory/emif-asm-offsets.s for writing: No such file or directory
> compilation terminated.
> drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
> make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
> .../Makefile:1060: recipe for target 'arch/arm/mach-omap2' failed
> make[1]: *** [arch/arm/mach-omap2] Error 2
> 
> This prevents any kernel being built that includes decending into
> arch/arm/mach-omap2 with split object directories.
> 
> This is a regression.

Dave, I presume you're looking into this already?

Regards,

Tony
