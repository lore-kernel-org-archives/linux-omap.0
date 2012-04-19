From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 3/8] ARM: OMAP2+: hwmod: reorganize and document the
 setup process
Date: Thu, 19 Apr 2012 10:22:34 +0200
Message-ID: <4F8FCB4A.3080805@ti.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053651.16278.22844.stgit@dusk> <alpine.DEB.2.00.1204190208470.29048@utopia.booyaka.com> <alpine.DEB.2.00.1204190214250.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51405 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab2DSIWj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 04:22:39 -0400
In-Reply-To: <alpine.DEB.2.00.1204190214250.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 4/19/2012 10:17 AM, Paul Walmsley wrote:

...

>   static int __init omap_hwmod_setup_all(void)
>   {
> -	int r;
> -
> -	if (!mpu_oh) {
> -		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n",
> -		       __func__, MPU_INITIATOR_NAME);
> -		return -EINVAL;
> -	}
> -
> -	r = omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
> -
> -	r = omap_hwmod_for_each(_init_clocks, NULL);
> -	WARN(IS_ERR_VALUE(r),
> -	     "omap_hwmod: %s: _init_clocks failed\n", __func__);
> +	_ensure_mpu_hwmod_is_setup(NULL);
>
> +	omap_hwmod_for_each(_init, NULL);
>   	omap_hwmod_for_each(_setup, NULL);

Does it make sense to iterate twice? Cannot we just iterate over a _init 
+ _setup single call?

Regards,
Benoit

