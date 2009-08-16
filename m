From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3: Overo: fix merge error
Date: Sun, 16 Aug 2009 14:56:50 -0700
Message-ID: <5e088bd90908161456y6f2da09aud9e1a86c0a5dbca6@mail.gmail.com>
References: <5e088bd90908161356j4d78fa1dn5e0f82f62bdd180d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:33601 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbZHPV4t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 17:56:49 -0400
Received: by qyk34 with SMTP id 34so1917464qyk.33
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 14:56:50 -0700 (PDT)
In-Reply-To: <5e088bd90908161356j4d78fa1dn5e0f82f62bdd180d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Please ignore this patch!

A previously submitted version seems to have made its way into
linux-omap since I pulled a couple of days ago.

Sorry for the noise.

Steve

On Sun, Aug 16, 2009 at 1:56 PM, Steve Sakoman<sakoman@gmail.com> wrote=
:
> Missing definition for OVERO_GPIO_PENDOWN
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>
> ---
> =A0arch/arm/mach-omap2/board-overo.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-overo.c
> b/arch/arm/mach-omap2/board-overo.c
> index 3fd614e..65bf008 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -51,6 +51,7 @@
>
> =A0#define OVERO_GPIO_BT_XGATE =A0 =A015
> =A0#define OVERO_GPIO_W2W_NRESET =A016
> +#define OVERO_GPIO_PENDOWN =A0 =A0 114
> =A0#define OVERO_GPIO_BT_NRESET =A0 164
> =A0#define OVERO_GPIO_USBH_CPEN =A0 168
> =A0#define OVERO_GPIO_USBH_NRESET 183
> --
> 1.6.0.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
