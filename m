From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 08/12] ARM: DRA7: Reuse the omap44xx_restart and fix the
 device instance
Date: Sun, 14 Jul 2013 13:12:48 +0100
Message-ID: <51E295C0.4080309@linaro.org>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com> <1373355139-12487-9-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39619 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab3GOFwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 01:52:23 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so10835306pbc.18
        for <linux-omap@vger.kernel.org>; Sun, 14 Jul 2013 22:52:22 -0700 (PDT)
In-Reply-To: <1373355139-12487-9-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com

On 07/09/2013 08:32 AM, Rajendra Nayak wrote:
> The omap44xx_restart used on omap4 and omap5 devices can be reused
> on dra7 devices as well. The device instance however is different
> across omap5 and dra7 as compared to omap4. So fix this for omap5
> as well as dra7.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>

[...]

> @@ -165,10 +168,19 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
>  void omap4_prminst_global_warm_sw_reset(void)
>  {
>  	u32 v;
> -
> -	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
> -				    OMAP4430_PRM_DEVICE_INST,
> -				    OMAP4_PRM_RSTCTRL_OFFSET);
> +	s16 dev_inst;
> +
> +	if (cpu_is_omap44xx())
> +		dev_inst = OMAP4430_PRM_DEVICE_INST;

Please don't use cpu_is_* (or soc_is_*) at runtime.  Rather, the right
offset/instance should be setup at init time.

Kevin

