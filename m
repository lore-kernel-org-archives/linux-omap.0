From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH v4 2/4] ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
Date: Fri, 11 Jan 2013 00:08:28 -0800
Message-ID: <CA+Bv8XZ_B-yKnmFNaUw3Xp3pss3WmcN+WxZ7YYZ4-TPgc2dGMQ@mail.gmail.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
	<1355464997-19367-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:59232 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab3AKII3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 03:08:29 -0500
Received: by mail-qc0-f177.google.com with SMTP id u28so942888qcs.36
        for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 00:08:28 -0800 (PST)
In-Reply-To: <1355464997-19367-3-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: a.zummo@towertech.it, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, rtc-linux@googlegroups.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>

On Thu, Dec 13, 2012 at 10:03 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> Set ti,pmic-shutdown-controller for BeagleBone in am335x-bone.dts
> file, this flag is used by the driver to set tps65217 PMIC status
> to OFF when PWR_EN toggle.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks good

Reviewed-by: Russ Dill <russ.dill@ti.com>
Acked-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone.dts |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 5302f79..e7dff9d 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -88,6 +88,8 @@
>  /include/ "tps65217.dtsi"
>
>  &tps {
> +       ti,pmic-shutdown-controller;
> +
>         regulators {
>                 dcdc1_reg: regulator@0 {
>                         regulator-always-on;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
