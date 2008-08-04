From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] Add option for DSP bridge debugging.
Date: Mon, 4 Aug 2008 18:55:22 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E0B031433@dlee03.ent.ti.com>
References: <1217857656-31431-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45329 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbYHDXza convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 19:55:30 -0400
In-Reply-To: <1217857656-31431-1-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

Hi Felipe,
          The bridge debug option looks good.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Contreras
> Sent: Monday, August 04, 2008 8:48 AM
> To: linux-omap@vger.kernel.org
> Cc: Felipe Contreras
> Subject: [PATCH] Add option for DSP bridge debugging.
>
> ---
>  drivers/dsp/dspbridge/Kconfig               |    3 +++
>  drivers/dsp/dspbridge/mpu_driver/src/Kbuild |    2 +-
>  2 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/dsp/dspbridge/Kconfig b/drivers/dsp/dspbridge/Kconfig
> index 5d5622d..580c148 100644
> --- a/drivers/dsp/dspbridge/Kconfig
> +++ b/drivers/dsp/dspbridge/Kconfig
> @@ -29,4 +29,7 @@ config BRIDGE_PM
>         DSP Bridge employs power management techniques to save dynamic and
>         static power consumption of the IVA sub system.
>
> +config BRIDGE_DEBUG
> +       bool "DSP Bridge Debug Support"
> +
>  endif
> diff --git a/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
> b/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
> index b6ad62a..62ca643 100644
> --- a/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
> +++ b/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
> @@ -33,7 +33,7 @@ ccflags-y = -DDISABLE_BRIDGE_PM
>  endif
>
>  # Debug
> -ifeq ($(CONFIG_DEBUG_KERNEL),y)
> +ifeq ($(CONFIG_BRIDGE_DEBUG),y)
>  ccflags-y += -DGT_TRACE -DDEBUG
>  endif
>
> --
> 1.5.6.2.1.g1a51b
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
