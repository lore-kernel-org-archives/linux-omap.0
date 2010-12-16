From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v4 4/5] OMAP: mailbox: build device using omap_device/omap_hwmod
Date: Thu, 16 Dec 2010 14:08:11 +0530
Message-ID: <AANLkTik4K3LEovr-wJiv_PG+ivHNj8hxPT7QPua-ytVf@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com> <1292482079-2226-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33601 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752381Ab0LPIiw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 03:38:52 -0500
Received: by mail-iy0-f171.google.com with SMTP id 21so1338187iyj.30
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 00:38:51 -0800 (PST)
In-Reply-To: <1292482079-2226-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

couple of comments.

On Thu, Dec 16, 2010 at 12:17, Omar Ramirez Luna <omar.ramirez@ti.com> =
wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> Remove static platform_device and resource data within
> omap mailbox driver; use the one defined in the hwmod
> database along with omap_device framework for device
> build and registration.
>
> Add device latency functions to be used, so clock can be
> enabled and sysconfig is configured.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> =A0arch/arm/mach-omap2/devices.c | =A0102 ++++++++-------------------=
--------------
> =A01 files changed, 20 insertions(+), 82 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devi=
ces.c
> index b5cafd3..7493c30 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -142,95 +142,33 @@ static inline void omap_init_camera(void)
> =A0#endif

<<snip>>

> +
> + =A0 =A0 =A0 oh =3D omap_hwmod_lookup("mailbox");
> + =A0 =A0 =A0 if (!oh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to find hwmod\n", __=
func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 od =3D omap_device_build("omap-mailbox", -1, oh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_latencies, ARRAY_S=
IZE(mbox_latencies),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0);
> + =A0 =A0 =A0 if (!od) {

Check for IS_ERR(od).

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: could not build device\n", =
__func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;

This "return" can be removed.

> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 platform_device_register(&mbox_device);
> =A0}
> =A0#else
> =A0static inline void omap_init_mbox(void) { }
> --
> 1.7.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
