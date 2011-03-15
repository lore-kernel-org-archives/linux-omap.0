From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH V2] OMAP4: Intialize IVA Device in addition to DSP device.
Date: Tue, 15 Mar 2011 10:48:37 +0530
Message-ID: <AANLkTinympnok4Qw_n15ukDNE2L5yp9xvuhoP64B=2wJ@mail.gmail.com>
References: <1299926361-28482-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:32949 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920Ab1COFS7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 01:18:59 -0400
Received: by wyj26 with SMTP id 26so183208wyj.10
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 22:18:57 -0700 (PDT)
In-Reply-To: <1299926361-28482-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Mar 12, 2011 at 16:09, Shweta Gulati <shweta.gulati@ti.com> wro=
te:
> OMAP4 has two different Devices IVA and DSP. DSP is bound
> with IVA for DVFS. The registration of IVA dev in API
> 'omap2_init_processor_devices' was missing. Init dev for
> 'iva_dev' is added.
>
> This also fixes the following error seen during boot as
> omap2_set_init_voltage can now find the iva device
>
> =A0 =A0 =A0 =A0omap2_set_init_voltage: Invalid parameters!
> =A0 =A0 =A0 =A0omap2_set_init_voltage: Unable to put vdd_iva to its i=
nit voltage
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
>
> Tested on OMAP4430 SDP Board.
> Baseline:
> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.=
git
> Branch :pm-core
>
> V2:
> Rephrased the Commit log.
>
> =A0arch/arm/mach-omap2/pm.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 30af335..49486f5 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
> =A0 =A0 =A0 =A0if (cpu_is_omap44xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_init_omap_device("l3_main_1", &l3_dev=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_init_omap_device("dsp", &dsp_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _init_omap_device("iva", &iva_dev);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_init_omap_device("l3_main", &l3_dev);
> =A0 =A0 =A0 =A0}
> --
Looks fine to me.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
