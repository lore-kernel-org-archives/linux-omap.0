From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 6/6] omap3: beagle: get rid of unused omap2/omap4 specific code/data
Date: Tue, 21 Dec 2010 13:15:23 -0600
Message-ID: <AANLkTim34_B_S--yYrdy+WOFH6_PL=t8P5xixwp36cwx@mail.gmail.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1292955604-8809-7-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:36593 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751677Ab0LUTQi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 14:16:38 -0500
Received: by mail-wy0-f176.google.com with SMTP id 20so4867281wye.7
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 11:16:35 -0800 (PST)
In-Reply-To: <1292955604-8809-7-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <tpetazzoni@ti.com>, Thomas Petazzoni <t-petazzoni@ti.com>

On Tue, Dec 21, 2010 at 12:20, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
>
> From: Thomas Petazzoni <tpetazzoni@ti.com>
>
> Using the new condsections infrastructure, get rid of the unused
> code/data for OMAP2 and OMAP4 when booting on BeagleBoard OMAP3.
>
> Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 14f4224..900964a 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -23,6 +23,7 @@
> =A0#include <linux/gpio.h>
> =A0#include <linux/input.h>
> =A0#include <linux/gpio_keys.h>
> +#include <linux/condsections.h>
>
> =A0#include <linux/mtd/mtd.h>
> =A0#include <linux/mtd/partitions.h>
> @@ -581,6 +582,9 @@ static void __init omap3_beagle_init(void)
> =A0 =A0 =A0 =A0omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>
> =A0 =A0 =A0 =A0beagle_display_init();
> +
> + =A0 =A0 =A0 free_unused_cond_section("omap2");
> + =A0 =A0 =A0 free_unused_cond_section("omap4");

Potentially a dumb idea: given that silicon wont change after boot,
cant we make it independent of the board file - I mean some common
file with cpu_is check and free of conditional sections accordingly?

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
