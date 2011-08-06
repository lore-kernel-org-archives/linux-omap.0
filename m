From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 8/9] ARM: platform_device: pdev_archdata: add omap_device pointer
Date: Sat, 6 Aug 2011 09:31:14 +0100
Message-ID: <CACxGe6sJsvPTS_+T9mYHVeG7GmXOq-KBqX+FdNiFrbnfaXa1pw@mail.gmail.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com> <1312589965-19416-9-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f52.google.com ([209.85.212.52]:47985 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1HFIbf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Aug 2011 04:31:35 -0400
Received: by vws16 with SMTP id 16so2504598vws.11
        for <linux-omap@vger.kernel.org>; Sat, 06 Aug 2011 01:31:34 -0700 (PDT)
In-Reply-To: <1312589965-19416-9-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Aug 6, 2011 at 1:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> Add omap_device pointer to the ARM-specific arch data in the
> platform_device. =A0This will be used to attach OMAP-specific
> device-data to the platform device with device lifetime.
>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/arm/include/asm/device.h | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/dev=
ice.h
> index 9f390ce..b5c9f5b 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -12,7 +12,12 @@ struct dev_archdata {
> =A0#endif
> =A0};
>
> +struct omap_device;
> +
> =A0struct pdev_archdata {
> +#ifdef CONFIG_ARCH_OMAP
> + =A0 =A0 =A0 struct omap_device *od;
> +#endif
> =A0};
>
> =A0#endif
> --
> 1.7.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
