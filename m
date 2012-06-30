From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] OMAP4430: USB Host: Implement workaround for Errata
 i687
Date: Sun, 01 Jul 2012 01:36:58 +0400
Message-ID: <4FEF717A.8000703@mvista.com>
References: <1340961065-26938-1-git-send-email-ruslan.bilovol@ti.com> <1340961065-26938-2-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34250 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab2F3Vhy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jun 2012 17:37:54 -0400
Received: by lbbgm6 with SMTP id gm6so6127449lbb.19
        for <linux-omap@vger.kernel.org>; Sat, 30 Jun 2012 14:37:52 -0700 (PDT)
In-Reply-To: <1340961065-26938-2-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, balbi@ti.com

Hello.

On 29-06-2012 13:11, Ruslan Bilovol wrote:

> The OMAP4 EHCI controller has the following defect (errata ID i687):

> Title:
> 	USB TLL Hold Timing Violation

> Description:
> 	There is a timing hold violation on an internal logic on
> 	the clock USB TLL path resulting in a systematic connection
> 	failure on the TLL link

> WORKAROUND:
> 	As part of workaround, next should be done:
> 	Set the I/O drive strength to 1.
> 	Depending which USB host subsystem is used,
> 	=E2=80=A2 Port B1 used: Set CONTROL.CONTROL_SMART2IO_PADCONF_2[11] U=
SBB1_DR0_DS =3D 0x1
> 	=E2=80=A2 Port B2 used: Set CONTROL.CONTROL_SMART2IO_PADCONF_2[12] U=
SBB2_DR0_DS =3D 0x1

> All OMAP4430 devices are impacted.

> Signed-off-by: Ruslan Bilovol<ruslan.bilovol@ti.com>
> ---
>   arch/arm/mach-omap2/usb-host.c |   17 +++++++++++++++++
>   1 files changed, 17 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb=
-host.c
> index dde8a11..3a6f2a2 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
[...]
> @@ -252,6 +253,14 @@ void __init setup_4430ehci_io_mux(const enum usb=
hs_omap_port_mode *port_mode)
>   			OMAP_PIN_INPUT_PULLDOWN);
>   		omap_mux_init_signal("usbb1_ulpitll_dat7",
>   			OMAP_PIN_INPUT_PULLDOWN);
> +
> +		/* Errata i687: set I/O drive strength to 1 */
> +		if (cpu_is_omap443x()) {
> +			u32 val;

    Empty line after the declaration block wouldn't hurt...

> +			val =3D omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_S=
MART2IO_PADCONF_2);
> +			val |=3D OMAP4_USBB1_DR0_DS_MASK;
> +			omap4_ctrl_pad_writel(val, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMA=
RT2IO_PADCONF_2);
> +		}
>   			break;
>   	case OMAP_USBHS_PORT_MODE_UNUSED:
>   	default:
> @@ -309,6 +318,14 @@ void __init setup_4430ehci_io_mux(const enum usb=
hs_omap_port_mode *port_mode)
>   			OMAP_PIN_INPUT_PULLDOWN);
>   		omap_mux_init_signal("usbb2_ulpitll_dat7",
>   			OMAP_PIN_INPUT_PULLDOWN);
> +
> +		/* Errata i687: set I/O drive strength to 1 */
> +		if (cpu_is_omap443x()) {
> +			u32 val;

    Same here...

> +			val =3D omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_S=
MART2IO_PADCONF_2);
> +			val |=3D OMAP4_USBB2_DR0_DS_MASK;
> +			omap4_ctrl_pad_writel(val, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMA=
RT2IO_PADCONF_2);
> +		}
>   			break;
>   	case OMAP_USBHS_PORT_MODE_UNUSED:
>   	default:

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
