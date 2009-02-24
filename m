From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 17/23] usb: host: ehci: fix register
	definitions
Date: Wed, 25 Feb 2009 00:42:58 +0200
Message-ID: <6ed0b2680902241442n5d1a6303s4563af722b269ce3@mail.gmail.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
	 <1235415335-17408-18-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:46587 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758295AbZBXWnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:43:14 -0500
Received: by fxm11 with SMTP id 11so3234340fxm.13
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 14:43:11 -0800 (PST)
In-Reply-To: <1235415335-17408-18-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>

On Mon, Feb 23, 2009 at 8:55 PM, Felipe Balbi <me@felipebalbi.com> wrot=
e:
> Make the register definitions in ehci-omap.c more sane.
> Also change the parameter passed omap_start/stop_ehc().
>
> Signed-off-by: Felipe Balbi <me@felipebalbi.com>
> ---
> =A0drivers/usb/host/ehci-omap.c | =A0219 +++++++++++++++++++++-------=
--------------
> =A01 files changed, 111 insertions(+), 108 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-oma=
p.c
> index cd891cc..c9305a3 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c

<snip>


> @@ -343,84 +346,87 @@ static int omap_start_ehc(struct ehci_hcd_omap =
*omap, struct usb_hcd *hcd)
> =A0 =A0 =A0 =A0clk_enable(omap->usbtll_ick);
>
> =A0 =A0 =A0 =A0/* Disable Auto Idle of USBTLL */
> - =A0 =A0 =A0 cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL_SHIFT),
> + =A0 =A0 =A0 cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CORE_M=
OD, CM_AUTOIDLE3);
>
> =A0 =A0 =A0 =A0/* Wait for TLL to be Active */
> =A0 =A0 =A0 =A0while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (1 << OMAP3430ES2_ST_=
USBTLL_SHIFT))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (0 << OMAP3430ES2_ST_=
USBTLL_SHIFT))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(timeout, jiffies)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(hcd->self.contr=
oller, "operation timed out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(omap->dev, "ope=
ration timed out\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_idlest3;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* perform TLL soft reset, and wait until reset is com=
plete */
> - =A0 =A0 =A0 omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
> + =A0 =A0 =A0 omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG)=
;

You forgot to remove the actual shift here

>
> =A0 =A0 =A0 =A0/* Wait for TLL reset to complete */
> =A0 =A0 =A0 =A0while (!(omap_readl(OMAP_USBTLL_SYSSTATUS)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (1 << OMAP_USBTLL_SYS=
STATUS_RESETDONE_SHIFT))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (1 << OMAP_USBTLL_SYS=
STATUS_RESETDONE))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();

and here, that's why it locks up.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(timeout, jiffies)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(hcd->self.contr=
oller, "operation timed out\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(omap->dev, "ope=
ration timed out\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_sys_status;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
> + =A0 =A0 =A0 dev_dbg(omap->dev, "TLL RESET DONE\n");
>
> =A0 =A0 =A0 =A0/* (1<<3) =3D no idle mode only for initial debugging =
*/
> - =A0 =A0 =A0 omap_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT=
) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_USBTLL_SYSCO=
NFIG_SIDLEMODE_SHIFT) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_USBTLL_SYSCO=
NFIG_CACTIVITY_SHIFT),
> + =A0 =A0 =A0 omap_writel(OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_S=
IDLEMODE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_USBTLL_SYSCONFIG_C=
ACTIVITY,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_USBTLL_SYSCONFIG)=
;
>
>
> =A0 =A0 =A0 =A0/* Put UHH in NoIdle/NoStandby mode */
> - =A0 =A0 =A0 omap_writel((0 << OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_UHH_SYSCONFI=
G_ENAWAKEUP_SHIFT) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_UHH_SYSCONFI=
G_SIDLEMODE_SHIFT) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_UHH_SYSCONFI=
G_CACTIVITY_SHIFT) |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_UHH_SYSCONFI=
G_MIDLEMODE_SHIFT),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UHH_SYSCONFIG);
> + =A0 =A0 =A0 reg =3D omap_readl(OMAP_UHH_SYSCONFIG);
> + =A0 =A0 =A0 reg |=3D (OMAP_UHH_SYSCONFIG_ENAWAKEUP
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_UHH_SYSCONFIG_SI=
DLEMODE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_UHH_SYSCONFIG_CA=
CTIVITY
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_UHH_SYSCONFIG_MI=
DLEMODE);
> + =A0 =A0 =A0 reg &=3D ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
> +
> + =A0 =A0 =A0 omap_writel(reg, OMAP_UHH_SYSCONFIG);
>
> =A0 =A0 =A0 =A0if (omap->phy_mode =3D=3D EHCI_HCD_OMAP_MODE_PHY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_readl(OMAP_UHH_HOSTCONFIG)=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP_UHH_HOSTCONFIG_INCR4_BUR=
ST_EN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_=
UHH_HOSTCONFIG_INCR8_BURST_EN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_=
UHH_HOSTCONFIG_INCR16_BURST_EN);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP_UHH_HOSTCONFIG_ULPI_BYP=
ASS
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | OMAP_=
UHH_HOSTCONFIG_INCRX_ALIGN_EN);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Bypass the TLL module for PHY mode =
operation */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel((0 << OMAP_UHH_HOSTCONFIG_U=
LPI_BYPASS_SHIFT)|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_UHH_HOSTCONF=
IG_INCR4_BURST_EN_SHIFT)|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_UHH_HOSTCONF=
IG_INCR8_BURST_EN_SHIFT)|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP_UHH_HOSTCONF=
IG_INCR16_BURST_EN_SHIFT)|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP_UHH_HOSTCONF=
IG_INCRX_ALIGN_EN_SHIFT),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_UHH_HOSTCONFIG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(reg, OMAP_UHH_HOSTCONFIG);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Ensure that BYPASS is set */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (omap_readl(OMAP_UHH_HOSTCONFIG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (1 << OMAP_UHH_HOSTCO=
NFIG_ULPI_BYPASS_SHIFT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & (1 << OMAP_UHH_HOSTCO=
NFIG_ULPI_BYPASS)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();

here too..

building now a kernel with these fixed..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
