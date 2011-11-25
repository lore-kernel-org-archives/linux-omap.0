From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC][PATCH 1/1] OMAP: voltage: add a hook for normal regulator
 calls
Date: Fri, 25 Nov 2011 06:29:37 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143032D30@DBDE01.ent.ti.com>
References: <1321547303-21807-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53836 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1KYG3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Nov 2011 01:29:46 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAP6ThCU017819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 00:29:45 -0600
In-Reply-To: <1321547303-21807-1-git-send-email-vaibhav.bedia@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kattekola, Ravikumar" <rk@ti.com>

Hi,

On Thu, Nov 17, 2011 at 21:58:23, Bedia, Vaibhav wrote:
> TI processors in TI81x and AM33x family work with PMICs like
> TPS65910/1 which are not part of the TWL series. These processors
> also do not have a voltage controller/processor module.
> 
> In order to invoke the normal regulator calls from the voltage
> layer the following changes are done to struct voltagedomain
> 	- Add a flag use_regulator for the SoC voltagedomain
> 	  code to indicate its intention of using a PMIC which
> 	  is not controlled by VC/VP
> 	- Add a regulator_init callback which the platform code
> 	  can utilise for any custom init sequence before making
> 	  use of the regulator. Platform code is also expected
> 	  to set the voltdm->scale function in the init callback
> 
> Signed-off-by: Ravikumar Kattekola <rk@ti.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c |    5 +++++
>  arch/arm/mach-omap2/voltage.h |    4 ++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 1f8fdf7..ca4ef9e 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -280,6 +280,11 @@ int __init omap_voltage_late_init(void)
>  			voltdm->scale = omap_vp_forceupdate_scale;
>  			omap_vp_init(voltdm);
>  		}
> +
> +		if (voltdm->use_regulator) {
> +			if(voltdm->regulator_init)
> +				voltdm->regulator_init(voltdm);
> +		}
>  	}
>  
>  	return 0;
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 16a1b09..21c810f 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -88,6 +88,10 @@ struct voltagedomain {
>  
>  	u32 nominal_volt;
>  	struct omap_volt_data *volt_data;
> +
> +	bool use_regulator;
> +	struct regulator *regulator;
> +	int (*regulator_init) (struct voltagedomain *voltdm);
>  };
>  

Any comments on this approach? This enables us to make use of generic regulators calls
from the voltage layer. Since TI81xx and AM33xx do not have VC/VP we need something like this 
for implementing DVFS.

Regards,
Vaibhav
