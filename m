From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH linux-next] ARM: OMAP2+: fix omap4-restart compilation
Date: Thu, 27 Jun 2013 08:18:06 -0500
Message-ID: <51CC3B8E.8070702@ti.com>
References: <1372335961-31401-1-git-send-email-vincent.stehle@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1372335961-31401-1-git-send-email-vincent.stehle@freescale.com>
Sender: linux-next-owner@vger.kernel.org
To: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@freescale.com>
Cc: linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, trivial@kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On 06/27/2013 07:26 AM, Vincent Stehl=C3=A9 wrote:
> Fix following compilation error due to missing include file:
>
>    arch/arm/mach-omap2/omap4-restart.c:21:28: warning: =E2=80=98enum =
reboot_mode=E2=80=99 declared inside parameter list [enabled by default=
]
>    arch/arm/mach-omap2/omap4-restart.c:21:28: warning: its scope is o=
nly this definition or declaration, which is probably not what you want=
 [enabled by default]
>    arch/arm/mach-omap2/omap4-restart.c:21:40: error: parameter 1 (=E2=
=80=98mode=E2=80=99) has incomplete type
>    arch/arm/mach-omap2/omap4-restart.c:21:6: warning: function declar=
ation isn=E2=80=99t a prototype [-Wstrict-prototypes]
>    make[1]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@freescale.com>
> Cc: Robin Holt <holt@sgi.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: trivial@kernel.org
> ---
>
>
> Hi,
>
> This fixes the build of linux-next for arch ARM, config multi_v7_defc=
onfig, tag
> next-20130627.
>
> Best regards,
>
> V.
>
>
>   arch/arm/mach-omap2/omap4-restart.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap=
2/omap4-restart.c
> index 652adde..41dfd7d 100644
> --- a/arch/arm/mach-omap2/omap4-restart.c
> +++ b/arch/arm/mach-omap2/omap4-restart.c
> @@ -8,6 +8,7 @@
>    */
>
>   #include <linux/types.h>
> +#include <linux/reboot.h>
>   #include "prminst44xx.h"
>
>   /**
>
Same was covered already?
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/178209.=
html

--=20
Regards,
Nishanth Menon
