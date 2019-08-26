From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: move platform-specific asm-offset.h to
 arch/arm/mach-omap2
Date: Mon, 26 Aug 2019 09:20:21 -0700
Message-ID: <20190826162021.GW52127@atomide.com>
References: <20190823025808.11875-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823025808.11875-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Masahiro Yamada <yamada.masahiro@socionext.com> [190822 19:59]:
> <generated/ti-pm-asm-offsets.h> is only generated and included by
> arch/arm/mach-omap2/, so it does not need to reside in the globally
> visible include/generated/.
> 
> I renamed it to arch/arm/mach-omap2/pm-asm-offsets.h since the prefix
> 'ti-' is just redundant in mach-omap2/.
> 
> My main motivation of this change is to avoid the race condition for
> the parallel build (-j) when CONFIG_IKHEADERS is enabled.
> 
> When it is enabled, all the headers under include/ are archived into
> kernel/kheaders_data.tar.xz and exposed in the sysfs.
> 
> In the parallel build, we have no idea in which order files are built.
> 
>  - If ti-pm-asm-offsets.h is built before kheaders_data.tar.xz,
>    the header will be included in the archive. Probably nobody will
>    use it, but it is harmless except that it will increase the archive
>    size needlessly.
> 
>  - If kheaders_data.tar.xz is built before ti-pm-asm-offsets.h,
>    the header will not be included in the archive. However, in the next
>    build, the archive will be re-generated to include the newly-found
>    ti-pm-asm-offsets.h. This is not nice from the build system point
>    of view.
> 
>  - If ti-pm-asm-offsets.h and kheaders_data.tar.xz are built at the
>    same time, the corrupted header might be included in the archive,
>    which does not look nice either.
> 
> This commit fixes the race.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Keerthy <j-keerthy@ti.com>

Applying into omap-for-v5.4/soc thanks. The commit is on top of
v5.3-rc1 so it can be merged into other branches if needed after
it's been sitting in Linux next for few days with no issues.

Regards,

Tony
