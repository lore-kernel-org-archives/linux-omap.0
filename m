From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/2] OMAP4: PMIC: Rename =?UTF-8?Q?twl=36=30=33=30=5Fcodec=20a?=
 =?UTF-8?Q?s=20twl=36=30=34=30=5Fcodec?=
Date: Sat, 13 Mar 2010 05:17:36 -0600
Message-ID: <ea13b3e438eb2455f4d0d91396f2500e@secure211.sgcpanel.com>
References: <1889FA7136B567478A67D4B0F85B0CCE66173AF6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54577 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759018Ab0CMLRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Mar 2010 06:17:43 -0500
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE66173AF6@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Samuel Ortiz <sameo@linux.intel.com>

Hi,

On Fri, 12 Mar 2010 19:52:15 -0600, "Olaya, Margarita" <magi.olaya@ti.com>
wrote:

please add a description here. Why do you need to rename it ?

> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

[snip]

> @@ -708,7 +708,7 @@ add_children(struct twl4030_platform_data *pdata,
> unsigned long features)
>  	/* Phoenix*/
>  	if (twl_has_codec() && pdata->codec && twl_class_is_6030()) {
>  		sub_chip_id = twl_map[TWL_MODULE_AUDIO_VOICE].sid;
> -		child = add_child(sub_chip_id, "twl6030_codec",
> +		child = add_child(sub_chip_id, "twl6040_codec",

you rename the platform_device but no the platform_driver ??
how do you expect the driver to probe() ??

-- 
balbi
