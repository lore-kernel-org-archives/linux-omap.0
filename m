From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Thu, 23 Feb 2012 19:18:28 +0530
Message-ID: <CAMQu2gxWYVPMBkj0oD=Cj5r1O+X4Y-Lgpntsvc+Jxj3X6XyviQ@mail.gmail.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com> <1330003320-17400-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51702 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab2BWNsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 08:48:51 -0500
Received: by mail-qw0-f43.google.com with SMTP id g1so16629411qab.9
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 05:48:51 -0800 (PST)
In-Reply-To: <1330003320-17400-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>
> patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OM=
AP4430
> Public TRM.
>
A brief about IO daisy in changelog would be good apart from TRM refere=
nce.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/prm44xx.c | =A0 32 +++++++++++++++++++++++++++=
+++++
> =A0arch/arm/mach-omap2/prm44xx.h | =A0 =A01 +
> =A02 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm4=
4xx.c
> index 33dd655..1557647 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -230,6 +230,41 @@ void omap44xx_prm_restore_irqen(u32 *saved_mask)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4=
_PRM_IRQENABLE_MPU_2_OFFSET);
> =A0}
>
> +/**
> + * Maximum time(us) it takes to output the signal WUCLKOUT of the la=
st pad of
> + * the I/O ring after asserting WUCLKIN high
> + */
> +#define MAX_IOPAD_LATCH_TIME 1000
> +
Is the 1000 us/ms ?
Is that documented or arbitrary chosen ?

Rest of the change looks good to me.

regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
