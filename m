From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Wed, 15 Oct 2014 18:18:30 -0400
Message-ID: <543EF2B6.1050009@hurleysoftware.com>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:47114 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750792AbaJOWSj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 18:18:39 -0400
In-Reply-To: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Nathan Lynch <Nathan_Lynch@mentor.com>, David Laight <David.Laight@ACULAB.COM>, Otavio Salvador <otavio@ossystems.com.br>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 10/15/2014 05:56 PM, Russell King wrote:
> These stock GCC versions miscompile the kernel by incorrectly optimising
> the function epilogue code - by first increasing the stack pointer, and
> then loading entries from below the stack.  This means that an opportune
> interrupt or exception will corrupt the current function's saved state,
> which may result in the parent function seeing different register
> values.
> 
> As this bug has been known to result in corrupted filesystems, and these
> buggy compiler versions seem to be frequently used, we have little
> option but to blacklist these compiler versions.
> 
> Distributions may have fixed PR58854, but as their compilers are totally
> indistinguishable from the buggy versions, it is unfortunate that this
> also results in those also being blacklisted.  Given the filesystem
> corruption potential of the original, this is the lesser evil.  People
> who want to build with their fixed compiler versions will need to adjust
> the kernel source.  (Distros need to think about the implications of
> fixing such a compiler bug, and consider how to ensure that their fixed
> compiler versions can be detected if they wish to avoid this.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> 
> This is what I came up with - this places the build check right at the
> beginning of the kernel build, rather than at some point where
> linux/compiler.h gets included.  Note that this is where we have
> previous ARM specific GCC version blacklisting.  I'm blacklisting
> GCC 4.8.0 to GCC 4.8.2 inclussive, which seems to be the right versions
> for stock GCC.
> 
> I was in two minds whether to include 4.8.3 as Linaro released a buggy
> toolchain which identifies itself as 4.8.3, but I decided that's also
> a distro problem.  IMHO Linaro should really think about taking that
> compiler down given the seriousness of this bug and it being
> indistinguishable from the fixed stock version.

Maybe it's unfair to blame them; Linaro just took a snapshot and
released what was there.

If gcc is going to retain the "change release number then add all the
new features" model, some kind of prerelease indicator would help
eliminate this kind of problem. And that indicator should be both
a preprocessor define and parseable from the command line :)


>  arch/arm/kernel/asm-offsets.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 713e807621d2..e14c1a12b414 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -10,6 +10,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#include <linux/compiler.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
>  #include <linux/dma-mapping.h>
> @@ -39,10 +40,19 @@
>   * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
>   *            (http://gcc.gnu.org/PR8896) and incorrect structure
>   *	      initialisation in fs/jffs2/erase.c
> + * GCC 4.8.0-4.8.2: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
> + *	      miscompiles find_get_entry(), and can result in EXT3 and EXT4
> + *	      filesystem corruption (possibly other FS too).
>   */
> +#ifdef __GNUC__
>  #if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
>  #error Your compiler is too buggy; it is known to miscompile kernels.
> -#error    Known good compilers: 3.3
> +#error    Known good compilers: 3.3, 4.x
> +#endif
> +#if GCC_VERSION >= 40800 || GCC_VERSION < 40803
                            ^^
                            &&

> +#error Your compiler is too buggy; it is known to miscompile kernels
> +#error and result in filesystem corruption and oopses.
> +#endif
>  #endif
>  
>  int main(void)
> 

Regards,
Peter Hurley
