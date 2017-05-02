From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 3/3] ti-soc-thermal: Fix a typo in a comment line
Date: Tue, 2 May 2017 09:21:13 +0530
Message-ID: <75adbe08-1254-ef9a-d7c8-08a9a35b31cd@ti.com>
References: <cd524803-b771-c3d2-8906-ee78576c86d4@users.sourceforge.net>
 <f1b47bde-bd8a-2a5d-a6b3-4c721628b243@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <f1b47bde-bd8a-2a5d-a6b3-4c721628b243@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 26 April 2017 09:09 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 26 Apr 2017 17:11:28 +0200
> 
> Add a missing character in this description for a function.

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 109fb0a5f19f..696ab3046b87 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1010,7 +1010,7 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
>  }
>  
>  /**
> - * ti_bandgap_set_continous_mode() - One time enabling of continuous mode
> + * ti_bandgap_set_continuous_mode() - One time enabling of continuous mode
>   * @bgp: pointer to struct ti_bandgap
>   *
>   * Call this function only if HAS(MODE_CONFIG) is set. As this driver may
> 
