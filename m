From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
Date: Thu, 23 Feb 2012 19:23:50 +0530
Message-ID: <CAMQu2gxQQTfiNoiwZszNWFiDWaei8+f6eKj+K2ZE1wNuvFLH9A@mail.gmail.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com> <1330003320-17400-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:45794 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755589Ab2BWNyM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 08:54:12 -0500
Received: by mail-qw0-f48.google.com with SMTP id h8so1634935qau.0
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 05:54:11 -0800 (PST)
In-Reply-To: <1330003320-17400-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> IO Daisychain feature has to be triggered whenever there is a change =
in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP)=
=2E
>
> Now devices can idle independent of the powerdomain, there can be a
> window where device is idled and corresponding powerdomain can be
> ON/INACTIVE state. In such situations, since both module wake up is
> enabled at padlevel as well as io daisychain sequence is triggered,
> there will be 2 PRCM interrupts (Module async wake up via swakeup and
> IO Pad interrupt). But as PRCM Interrupt handler clears the Module
> Padlevel WKST bit in the first interrupt, module specific interrupt
> handler will not triggered for the second time
>
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod.c | =A0 =A09 +++++++--
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 | =A0 =A07 +++++++
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A03 files changed, 15 insertions(+), 2 deletions(-)
>

[...]

>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 1881fe9..e8b54eb 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -25,6 +25,7 @@
> =A0#include "clockdomain.h"
> =A0#include "pm.h"
> =A0#include "twl-common.h"
> +#include "prm44xx.h"
>
> =A0static struct omap_device_pm_latency *pm_lats;
>
> @@ -64,6 +65,12 @@ static void omap2_init_processor_devices(void)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +void omap_trigger_wuclk_ctrl(void)
> +{
> + =A0 =A0 =A0 if (cpu_is_omap44xx())

can we avoid above check to make it generic so that even OMAP5 can use =
this
code without any change. Some flag might do the trick.

Rest of the patch looks fine to me.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
