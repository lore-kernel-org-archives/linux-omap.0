From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 1/5] arm: omap: hwmod: make *phy_48m* as the main_clk
 of ocp2scp
Date: Wed, 30 May 2012 20:18:02 +0530
Message-ID: <CAMQu2gw___u=g0=EQ3Q0fVuzG1gZKAoMpt268_Npbp26sWPHaA@mail.gmail.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com> <1338375394-16268-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59514 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754234Ab2E3OsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 10:48:24 -0400
Received: by qcsq13 with SMTP id q13so3629496qcs.17
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 07:48:22 -0700 (PDT)
In-Reply-To: <1338375394-16268-2-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com

On Wed, May 30, 2012 at 4:26 PM, Kishon Vijay Abraham I <kishon@ti.com>=
 wrote:
> Made *ocp2scp_usb_phy_phy_48m* as the main_clk for ocp2scp.
> Since this ocp2scp module does not have any fck but does have a
> single opt_clock, it is added as the main_clk for ocp2scp.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---


> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 950454a..249ff76 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2508,6 +2508,7 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_p=
hy_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "ocp2scp_usb_phy",
> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_ocp2scp_hwmod_=
class,
> =A0 =A0 =A0 =A0.clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> + =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "ocp2scp_usb_phy_phy_48m",
> =A0 =A0 =A0 =A0.prcm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap4 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.clkctrl_offs =3D OMAP=
4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/

Minor ..
$subject
s/arm: omap: / ARM: OMAP

An maintain this naming consistency since one of
the patch in the series uses capital where as others
not
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
