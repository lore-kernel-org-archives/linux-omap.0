From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 3/9] ARM: OMAP: DTB: Update IRQ data for WKUP_M3
Date: Wed, 7 Aug 2013 17:53:13 -0700
Message-ID: <CA+Bv8XbBPGtMnFfPtsFH_3-=v_0jBmruVFgUBY5Ycx-a_yr4LA@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-4-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:48948 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933571Ab3HHAxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 20:53:13 -0400
Received: by mail-qc0-f181.google.com with SMTP id k15so1270632qcv.12
        for <linux-omap@vger.kernel.org>; Wed, 07 Aug 2013 17:53:13 -0700 (PDT)
In-Reply-To: <1375811376-49985-4-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>

On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> Allow interrupt for wkup_m3 to be set from DT.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Cc: Benoit Cousson <benoit.cousson@linaro.org>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..05353bf 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -491,6 +491,7 @@
>                         compatible = "ti,am3353-wkup-m3";
>                         reg = <0x44d00000 0x4000        /* M3 UMEM */
>                                0x44d80000 0x2000>;      /* M3 DMEM */
> +                       interrupts = <78>;
>                         ti,hwmods = "wkup_m3";
>                 };
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
