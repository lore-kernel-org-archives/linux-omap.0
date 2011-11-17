From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH] ARM: omap_hwmod: Add a new state to handle hwmods left
 enabled at init
Date: Thu, 17 Nov 2011 16:18:55 +0530
Message-ID: <CAAL8m4yQTB_vJe9G8ArJx1Uoatd8ffXYY7NqEyM6zgCiygFc0A@mail.gmail.com>
References: <1321524690-10302-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39113 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab1KQKtR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 05:49:17 -0500
Received: by fagn18 with SMTP id n18so2715331fag.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 02:49:16 -0800 (PST)
In-Reply-To: <1321524690-10302-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com

On Thu, Nov 17, 2011 at 3:41 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> A hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
> enabled state by the hwmod framework post the initial setup.
> Once a real user of the device (a driver) tries to enable it
> at a later point, the hmwod framework throws a WARN() about
> the device being already in enabled state.
>
> Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
> to identify such devices/hwmods, so nothing but just a state
> change to '_HWMOD_STATE_ENABLED' can be done when the device/hwmod
> is requested to be enabled (the first time) by its driver/user.
>
> A good example of a such a device is an UART used as debug console.
> The UART module needs to be kept enabled through the boot, until the
> UART driver takes control of it, for debug prints to appear on
> the console.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

tested with uart runtime v8 patch series works fine.
helps to simply the serial.c code without using custom console activate=
 funcs.
thanks for handling this within the framework.

=46WIW,

Tested-by: Govindraj.R <govindraj.raja@ti.com>

--
Thanks,
Govindraj.R


> ---
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 16 =
++++++++++++++--
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 +
> =A02 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index d7f4623..7d94cc3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1441,6 +1441,17 @@ static int _enable(struct omap_hwmod *oh)
>
> =A0 =A0 =A0 =A0pr_debug("omap_hwmod: %s: enabling\n", oh->name);
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* hwmods' with HWMOD_INIT_NO_IDLE flag set, are left
> + =A0 =A0 =A0 =A0* in enabled state at init.
> + =A0 =A0 =A0 =A0* Now that someone is really trying to enable them,
> + =A0 =A0 =A0 =A0* just update the state.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (oh->_state =3D=3D _HWMOD_STATE_ENABLED_AT_INIT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->_state =3D _HWMOD_STATE_ENABLED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (oh->_state !=3D _HWMOD_STATE_INITIALIZED &&
> =A0 =A0 =A0 =A0 =A0 =A0oh->_state !=3D _HWMOD_STATE_IDLE &&
> =A0 =A0 =A0 =A0 =A0 =A0oh->_state !=3D _HWMOD_STATE_DISABLED) {
> @@ -1449,7 +1460,6 @@ static int _enable(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If an IP contains only one HW reset line, then de-a=
ssert it in order
> =A0 =A0 =A0 =A0 * to allow the module state transition. Otherwise the=
 PRCM will return
> @@ -1744,8 +1754,10 @@ static int _setup(struct omap_hwmod *oh, void =
*data)
> =A0 =A0 =A0 =A0 * it should be set by the core code as a runtime flag=
 during startup
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((oh->flags & HWMOD_INIT_NO_IDLE) &&
> - =A0 =A0 =A0 =A0 =A0 (postsetup_state =3D=3D _HWMOD_STATE_IDLE))
> + =A0 =A0 =A0 =A0 =A0 (postsetup_state =3D=3D _HWMOD_STATE_IDLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->_state =3D _HWMOD_STATE_ENABLED_AT_=
INIT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0postsetup_state =3D _HWMOD_STATE_ENABL=
ED;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (postsetup_state =3D=3D _HWMOD_STATE_IDLE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_idle(oh);
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index 1b81dfb..cd49d60 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -436,6 +436,7 @@ struct omap_hwmod_omap4_prcm {
> =A0#define _HWMOD_STATE_ENABLED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4
> =A0#define _HWMOD_STATE_IDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A05
> =A0#define _HWMOD_STATE_DISABLED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06
> +#define _HWMOD_STATE_ENABLED_AT_INIT =A0 =A0 =A0 =A0 =A0 7
>
> =A0/**
> =A0* struct omap_hwmod_class - the type of an IP block
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
