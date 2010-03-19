From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Fri, 19 Mar 2010 13:51:35 +0200
Message-ID: <94a0d4531003190451h23ad1a16x994973cdfeb3c83f@mail.gmail.com>
References: <Acq8TGBkJRXTEjd3QLyd0bJ27/2C7g==>
	 <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:64901 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab0CSLvh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 07:51:37 -0400
Received: by bwz1 with SMTP id 1so2873338bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 04:51:36 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA9E405F@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On Fri, Mar 5, 2010 at 12:12 PM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
> --- a/arch/arm/plat-omap/include/dspbridge/drv.h
> +++ b/arch/arm/plat-omap/include/dspbridge/drv.h
> @@ -389,4 +389,7 @@ extern u32 drv_request_resources(u32 dw_context, =
u32 *pDevNodeString);
> =C2=A0*/
> =C2=A0extern u32 drv_release_resources(u32 dw_context, struct drv_obj=
ect *hdrv_obj);
>
> +#ifdef CONFIG_BRIDGE_RECOVERY
> + =C2=A0 =C2=A0 =C2=A0 void bridge_recover_schedule(void);

The preprocessor macros shouldn't affect indenting AFAIK.

> +#endif
> =C2=A0#endif /* DRV_ */

> diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
> index 8d33142..a0cf5f0 100644
> --- a/drivers/dsp/bridge/Kconfig
> +++ b/drivers/dsp/bridge/Kconfig
> @@ -52,6 +52,14 @@ config WDT_TIMEOUT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Watchdog timer timeout value, afte=
r that time if the watchdog timer
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 counter is not reset the wdt overf=
low interrupt will be triggered
>
> +config BRIDGE_RECOVERY
> + =C2=A0 =C2=A0 =C2=A0 bool "DSP Recovery Support"
> + =C2=A0 =C2=A0 =C2=A0 depends on MPU_BRIDGE
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 In case of DSP fatal error, BRIDGE driv=
er will try to
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 recover itself.
> +
> +

Extra unnecessary space.

> =C2=A0comment "Bridge Notifications"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MPU_BRIDGE
>

I tried to rebase this patch on top of the latest head and the
user-space client never gets notified of the MMUFAULT. After manually
killing the process, the DSP is restarted correctly though.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
