From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 3/3] ARM: AM335x: Fix warning in timer.c
Date: Wed, 28 Nov 2012 15:51:42 +0530
Message-ID: <50B5E5B6.9080107@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com> <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45836 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946Ab2K1KV5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 05:21:57 -0500
In-Reply-To: <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Igor Grinberg <grinberg@compulab.co.il>



On 11/28/2012 7:45 AM, Jon Hunter wrote:
> When compiling the kernel with configuration options ...
>=20
>  # CONFIG_ARCH_OMAP2 is not set
>  # CONFIG_ARCH_OMAP3 is not set
>  # CONFIG_ARCH_OMAP4 is not set
>  # CONFIG_SOC_OMAP5 is not set
>  CONFIG_SOC_AM33XX=3Dy
>=20
>  ... the following build warning is seen.
>=20
>   CC      arch/arm/mach-omap2/timer.o
>   arch/arm/mach-omap2/timer.c:395:19: warning: =E2=80=98omap2_sync32k=
_clocksource_init=E2=80=99
>   	defined but not used [-Wunused-function]
>=20
> This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remo=
ve
> CONFIG_OMAP_32K_TIMER) where the omap2_sync32k_clocksource_init() is =
no
> longer referenced by the timer initialisation function for the AM335x
> device as it has no 32k-sync timer.
>=20
> Fix this by only including the omap2_sync32k_clocksource_init() funct=
ion
> if either OMAP2, OMAP3, OMAP4 or OMAP5 devices are enabled.
>=20
> Cc: Igor Grinberg <grinberg@compulab.co.il>
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20

Jon,

I applied all these patches and it fixes build warning and also I have
tested it on Bone platform without any issues.

I also ran parse on this and saw further warning,

  CHECK   arch/arm/mach-omap2/timer.c
arch/arm/mach-omap2/timer.c:193:13: warning: symbol 'omap_dmtimer_init'
was not declared. Should it be static?
arch/arm/mach-omap2/timer.c:213:12: warning: symbol
'omap_dm_timer_get_errata' was not declared. Should it be static?

Below patch fixes that too, feel free to merge it into your's


diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 085c7e7..1d1cfec 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -190,7 +190,7 @@ static struct device_node * __init
omap_get_timer_dt(struct of_device_id *match,
  * kernel registering these devices remove them dynamically from the d=
evice
  * tree on boot.
  */
-void __init omap_dmtimer_init(void)
+static void __init omap_dmtimer_init(void)
 {
        struct device_node *np;

@@ -210,7 +210,7 @@ void __init omap_dmtimer_init(void)
  *
  * Get the timer errata flags that are specific to the OMAP device
being used.
  */
-u32 __init omap_dm_timer_get_errata(void)
+static u32 __init omap_dm_timer_get_errata(void)
 {
        if (cpu_is_omap24xx())
                return 0;


Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
