From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/5] omap2plus: voltage: Trivial warning fix 'no return
 statement'
Date: Tue, 04 Jan 2011 12:43:41 -0600
Message-ID: <4D236A5D.9040803@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40380 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037Ab1ADSnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:43:45 -0500
Received: by mail-gx0-f173.google.com with SMTP id 24so6678051gxk.4
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:43:44 -0800 (PST)
In-Reply-To: <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the following:
[..]
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
> index 0ff1233..710f4ea 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -134,7 +134,10 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
>  int omap_voltage_late_init(void);
>  #else
>  static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
> -		struct omap_volt_pmic_info *pmic_info) {}
> +		struct omap_volt_pmic_info *pmic_info)
> +{
> +	return 0;
since we dont really succeed registering the pmic to voltage layer,
return -EINVAL?

[..]
-- 
Regards,
Nishanth Menon
