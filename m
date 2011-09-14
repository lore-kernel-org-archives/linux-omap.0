From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] mfd: omap: cleanup: use macros to check for TLL mode
Date: Wed, 14 Sep 2011 20:11:30 +0530
Message-ID: <CAP05o4K4X6-Qs-KogPCuZwyfMNTQ19wD4vPV+c4Xn0ftzMef7Q@mail.gmail.com>
References: <1316010433-6024-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:49790 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751710Ab1INOld convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 10:41:33 -0400
In-Reply-To: <1316010433-6024-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, gadiyar@ti.com, bigeasy@linutronix.de, balbi@ti.com, p-basak2@ti.com

On Wed, Sep 14, 2011 at 7:57 PM, Kishon Vijay Abraham I <kishon@ti.com>=
 wrote:
> In one particular place the old form of checking for TLL mode is used=
=2E
> This patch fixes the same by using macros to check for TLL mode.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> patch is created on top of runtime patches from keshava hsoted at
> git://gitorious.org/~kmg/mirrors/kmg-usbhs-pm.git
> branch:kmg-pm-1
> =A0drivers/mfd/omap-usb-host.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index e6f3b01..d43ca08 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -401,7 +401,7 @@ static void usbhs_omap_tll_init(struct device *de=
v, u8 tll_channel_count)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D ohci_omap3_fs=
lsmode(pdata->port_mode[i])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<< OMA=
P_TLL_CHANNEL_CONF_FSLSMODE_SHIFT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D OMAP_TLL_CHAN=
NEL_CONF_CHANMODE_FSLS;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (pdata->port_mode[i] =3D=3D O=
MAP_EHCI_PORT_MODE_TLL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (is_ehci_tll_mode(pdata->port=
_mode[i])) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Disable AutoIdle, B=
itStuffing and use SDR Mode */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg &=3D ~(OMAP_TLL_CH=
ANNEL_CONF_UTMIAUTOIDLE
> --
> 1.7.0.4
>
>

is this rebased to my pm branch of runtime pm adaptations?

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
