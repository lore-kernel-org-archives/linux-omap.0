From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: linux-next: panda build failed at arch/arm/mach-omap2/omap4-restart.c
Date: Tue, 25 Jun 2013 22:46:02 +0530
Message-ID: <CA+G9fYupw8Gi=5p2nKVJ9GqfhwBcTw7hyzGA8+K+gHmdL96mJg@mail.gmail.com>
References: <CA+G9fYv_9EQUmpRNPUwioSwJVXnXJC5odEKiMd=vKHNWYRT8xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:58262 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab3FYRQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 13:16:03 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so13812294oag.13
        for <linux-omap@vger.kernel.org>; Tue, 25 Jun 2013 10:16:02 -0700 (PDT)
In-Reply-To: <CA+G9fYv_9EQUmpRNPUwioSwJVXnXJC5odEKiMd=vKHNWYRT8xw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robin Holt <holt@sgi.com>, Linus Walleij <linus.walleij@linaro.org>, Andrey Konovalov <andrey.konovalov@linaro.org>, Russ Anderson <rja@sgi.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Milosz Wasilewski <milosz.wasilewski@linaro.org>

ping

On 23 June 2013 13:53, Naresh Kamboju <naresh.kamboju@linaro.org> wrote=
:
> Hi,
>
> panda build broken on linux-next branch
>
> kernel_config=3Domap2plus_defconfig
> KERNEL_VERSION=3D3.10.0-rc6
> KERNEL_GIT=3Dgit://git.kernel.org/pub/scm/linux/kernel/git/next/linux=
-next.git
> KERNEL_COMMIT=3De1a86578747376f08985627c84df088a5d0d1e92
>
> Build error log :
> -------------------
> 04:43:18   CC      arch/arm/mach-omap2/omap4-restart.o
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel=
_cloud/arch/arm/mach-omap2/omap4-restart.c:21:28:
> warning: =91enum reboot_mode=92 declared inside parameter list [enabl=
ed by
> default]
> 04:43:18  void omap44xx_restart(enum reboot_mode mode, const char *cm=
d)
> 04:43:18                             ^
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel=
_cloud/arch/arm/mach-omap2/omap4-restart.c:21:28:
> warning: its scope is only this definition or declaration, which is
> probably not what you want [enabled by default]
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel=
_cloud/arch/arm/mach-omap2/omap4-restart.c:21:40:
> error: parameter 1 (=91mode=92) has incomplete type
> 04:43:18  void omap44xx_restart(enum reboot_mode mode, const char *cm=
d)
> 04:43:18                                         ^
> 04:43:18 /mnt/ci_build/workspace/linux-next/hwpack/panda/label/kernel=
_cloud/arch/arm/mach-omap2/omap4-restart.c:21:6:
> warning: function declaration isn=92t a prototype [-Wstrict-prototype=
s]
> 04:43:18  void omap44xx_restart(enum reboot_mode mode, const char *cm=
d)
> 04:43:18       ^
> 04:43:18 make[2]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1
> 04:43:18 make[1]: *** [arch/arm/mach-omap2] Error 2
>
> Full build log:
> ------------------
> https://ci.linaro.org/jenkins/job/linux-next/hwpack=3Dpanda,label=3Dk=
ernel_cloud/lastBuild/console
>
> Suspecting patch which caused build failed:
> --------------------------------------------------------
> commit b61cdf2aebc5cd2f4efc4e0cbebeb8a91884a43e
> Author: Robin Holt <holt@sgi.com>
> Date:   Wed Jun 19 10:08:43 2013 +1000
>
> reboot: arm: change reboot_mode to use enum reboot_mode
>
> Preparing to move the parsing of reboot=3D to generic kernel code for=
ces the
> change in reboot_mode handling to use the enum.
>
> Signed-off-by: Robin Holt <holt@sgi.com>
>
> ...
> diff --git a/arch/arm/mach-omap2/omap4-restart.c
> b/arch/arm/mach-omap2/omap4-restart.c
> index f90e02e..652adde 100644
> --- a/arch/arm/mach-omap2/omap4-restart.c
> +++ b/arch/arm/mach-omap2/omap4-restart.c
> @@ -18,7 +18,7 @@
>   * Resets the SoC.  For @cmd, see the 'reboot' syscall in
>   * kernel/sys.c.  No return value.
>   */
> -void omap44xx_restart(char mode, const char *cmd)
> +void omap44xx_restart(enum reboot_mode mode, const char *cmd)
>  {
>         /* XXX Should save 'cmd' into scratchpad for use after reboot=
 */
>         omap4_prminst_global_warm_sw_reset(); /* never returns */
> ...
>
> Best regards
> Naresh Kamboju
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
