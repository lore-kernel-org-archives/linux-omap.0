From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] mfd: omap: Restore TLL initialization
Date: Fri, 24 Jun 2011 11:52:25 +0530
Message-ID: <BANLkTikFFUREhKyPaZrhHZje0KeaA3ef8Q@mail.gmail.com>
References: <1308862894-13802-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob119.obsmtp.com ([74.125.149.245]:36397 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751974Ab1FXG3L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 02:29:11 -0400
In-Reply-To: <1308862894-13802-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, ti@lists.linaro.org, parthab@india.ti.com, sameo@linux.intel.com, gadiyar@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>

On Fri, Jun 24, 2011 at 2:31 AM, Jassi Brar <jassisinghbrar@gmail.com> =
wrote:
> The commit
> =A07e6502d577106fb5b202bbaac64c5f1b065 'mfd: Add omap-usbhs runtime P=
M support'
> besides moving to RPM, removes necessary TLL initialization as well.
>
> Restore the TLL initialization, without which device detection fails.
>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
> =A0drivers/mfd/omap-usb-host.c | =A0 42 +++++++++++++++++++++++++++++=
+++++++++++++
> =A01 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.=
c
> index 8552195..12ca77b 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -640,6 +640,7 @@ static int usbhs_enable(struct device *dev)
> =A0 =A0 =A0 =A0struct usbhs_omap_platform_data *pdata =3D &omap->plat=
data;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag=
s =3D 0;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D 0;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeo=
ut;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
reg;
>
> =A0 =A0 =A0 =A0dev_dbg(dev, "starting TI HSUSB Controller\n");
> @@ -676,6 +677,47 @@ static int usbhs_enable(struct device *dev)
> =A0 =A0 =A0 =A0omap->usbhs_rev =3D usbhs_read(omap->uhh_base, OMAP_UH=
H_REVISION);
> =A0 =A0 =A0 =A0dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_r=
ev);
>
> + =A0 =A0 =A0 /* perform TLL soft reset, and wait until reset is comp=
lete */
> + =A0 =A0 =A0 usbhs_write(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_S=
OFTRESET);
> +
> + =A0 =A0 =A0 /* Wait for TLL reset to complete */
> + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(1000);
> + =A0 =A0 =A0 while (!(usbhs_read(omap->tll_base, OMAP_USBTLL_SYSSTAT=
US)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & OMAP_USBTLL_SYSSTATUS=
_RESETDONE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "operation=
 timed out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_tll;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dev_dbg(dev, "TLL RESET DONE\n");
> +
> + =A0 =A0 =A0 /* (1<<3) =3D no idle mode only for initial debugging *=
/
> + =A0 =A0 =A0 usbhs_write(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_E=
NAWAKEUP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_S=
IDLEMODE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_A=
UTOIDLE);
> +
> + =A0 =A0 =A0 /* Put UHH in NoIdle/NoStandby mode */
> + =A0 =A0 =A0 reg =3D usbhs_read(omap->uhh_base, OMAP_UHH_SYSCONFIG);
> + =A0 =A0 =A0 if (is_omap_usbhs_rev1(omap)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP_UHH_SYSCONFIG_ENAWAKEUP
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_=
UHH_SYSCONFIG_SIDLEMODE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_=
UHH_SYSCONFIG_CACTIVITY
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_=
UHH_SYSCONFIG_MIDLEMODE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
> + =A0 =A0 =A0 } else if (is_omap_usbhs_rev2(omap)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP4_UHH_SYSCONFIG_IDLEMODE_=
CLEAR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP4_UHH_SYSCONFIG_NOIDLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP4_UHH_SYSCONFIG_STDBYMODE=
_CLEAR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D OMAP4_UHH_SYSCONFIG_NOSTDBY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 usbhs_write(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
> +
> =A0 =A0 =A0 =A0reg =3D usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG=
);
> =A0 =A0 =A0 =A0/* setup ULPI bypass and burst configurations */
> =A0 =A0 =A0 =A0reg |=3D (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
> --
> 1.7.4.1

if you move to RPM, you should'tn access these configuration/reset
registers in your driver.
moreover, the patch 'mfd: Add omap-usbhs runtime PM support' is
already reverted.

keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
