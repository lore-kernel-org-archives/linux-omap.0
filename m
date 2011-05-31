From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: V 3.0-rc1: [REPORT] OMAP MMC and CONSOLE Regression
Date: Tue, 31 May 2011 12:16:52 +0530
Message-ID: <BANLkTimPzRieobbg6TMyRf725ALZxDGodg@mail.gmail.com>
References: <4DE38E88.1030402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33885 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751856Ab1EaGqx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 02:46:53 -0400
Received: by gxk7 with SMTP id 7so2376796gxk.7
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 23:46:52 -0700 (PDT)
In-Reply-To: <4DE38E88.1030402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>

On Mon, May 30, 2011 at 6:03 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> While trying out V3.0-rc1, I noticed couple of regressions. Am
> posting this in case anybody come across same issues.
>
> 1.OMAP MMC code keep throwing "Pbias Voltage is not same as LDO" erro=
r
> continuously.
>
> Balaji is planning post right fix for the same, but just
> in case you get around this issue,
>

Hi Santosh,
You can find MMC pbias fix here
http://www.spinics.net/lists/linux-omap/msg51735.html

> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index b2f30be..94ae400 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -145,6 +145,7 @@ static void omap4_hsmmc1_after_set_reg(struct dev=
ice
> *dev, int slot,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p=
ower_on, int vdd)
> =A0{
> =A0 =A0 =A0 =A0u32 reg;
> + =A0 =A0 =A0 unsigned long timeout;
>
> =A0 =A0 =A0 =A0if (power_on) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D omap4_ctrl_pad_readl(control_p=
bias_offset);
> @@ -158,7 +159,14 @@ static void omap4_hsmmc1_after_set_reg(struct de=
vice
> *dev, int slot,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_USBC1_ICUSB_PWRD=
NZ_MASK);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_ctrl_pad_writel(reg, control_pbi=
as_offset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 4 microsec delay for comparator to =
generate an error*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(=
500);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap4_ctrl_pad_=
readl(control_pbias_offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(reg & OMAP4_MMC1_=
PBIASLITE_VMODE_ERROR_MASK))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (!time_after(jiffies, timeout))=
;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D omap4_ctrl_pad_readl(control_p=
bias_offset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (reg & OMAP4_MMC1_PBIASLITE_VMODE_E=
RROR_MASK) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Pbias Voltage =
is not same as LDO\n");
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
