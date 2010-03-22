From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv2 03/17] OMAP3: PM: Convert smartreflex driver into a
 platform driver using hwmods and omap-device layer
Date: Mon, 22 Mar 2010 13:28:16 -0500
Message-ID: <4BA7B6C0.5000403@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com> <1268903755-4151-2-git-send-email-thara@ti.com> <1268903755-4151-3-git-send-email-thara@ti.com> <1268903755-4151-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328Ab0CVS2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Mar 2010 14:28:21 -0400
In-Reply-To: <1268903755-4151-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Gopinath, Thara had written, on 03/18/2010 04:15 AM, the following:
> This patch converts the exisitng smartreflex library into a
> platform driver with device , driver registrations using hardware mods.
> As part of this Ntarget values are passed as platform data.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
[...]

> +/*
> + * Hard coded nvalues for testing purposes for OMAP3430,
> + * may cause device to hang!
> + */
> +static void __init omap34xx_sr_set_testing_nvalues(
> +                               struct omap_smartreflex_data *sr_data, int srid)
> +{
> +       if (srid == SR1) {
> +               sr_data->no_opp = opp_get_opp_count(OPP_MPU);
> +               sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> +                               sr_data->no_opp , GFP_KERNEL);
> +               if (WARN_ON(!sr_data->sr_nvalue))
> +                       return;
> +
> +               sr_data->senp_mod = 0x03;       /* SenN-M5 enabled */
> +               sr_data->senn_mod = 0x03;
> +               /* calculate nvalues for each opp */
> +               sr_data->sr_nvalue[4] = 0x0;
> +               sr_data->sr_nvalue[3] = 0x0;
> +               sr_data->sr_nvalue[2] = 0x0;
> +               sr_data->sr_nvalue[1] = 0x0;
> +               sr_data->sr_nvalue[0] = 0x0;
> +       } else if (srid == SR2) {
> +               sr_data->no_opp = 3;
> +               sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> +                                       sr_data->no_opp , GFP_KERNEL);
> +               if (WARN_ON(!sr_data->sr_nvalue))
> +                       return;
> +
> +               sr_data->senp_mod = 0x03;       /* SenN-M5 enabled */
> +               sr_data->senn_mod = 0x03;
> +               sr_data->sr_nvalue[2] = 0x0;
> +               sr_data->sr_nvalue[1] = 0x0;
> +               sr_data->sr_nvalue[0] = 0x0;
> +       }
> +}
NAK to opp IDs, and IMHO if we can remove SRIDs as well, it will be good.
Related discussion in http://marc.info/?t=126893797600009&r=1&w=2

-- 
Regards,
Nishanth Menon
