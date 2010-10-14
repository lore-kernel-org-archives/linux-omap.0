From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 02/11] OMAP3: PM: Adding voltage driver support for
 OMAP3
Date: Thu, 14 Oct 2010 11:05:05 -0700
Message-ID: <1287079505.14514.55.camel@localhost>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	 <1285166719-19352-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39218 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab0JNV5E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 17:57:04 -0400
Received: by vws2 with SMTP id 2so76279vws.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 14:57:03 -0700 (PDT)
In-Reply-To: <1285166719-19352-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

On Wed, 2010-09-22 at 20:15 +0530, Thara Gopinath wrote:
> This patch adds voltage driver support for OMAP3. The driver
> allows  configuring the voltage controller and voltage
> processors during init and exports APIs to enable/disable
> voltage processors, scale voltage and reset voltage.
> The driver also maintains the global voltage table on a per
> VDD basis which contains the various voltages supported by the
> VDD along with per voltage dependent data like smartreflex
> n-target value, errminlimit and voltage processor errorgain.
> The driver allows scaling of VDD voltages either through
> "vc bypass method" or through "vp forceupdate method" the
> choice being configurable through the board file.
> 
> This patch contains code originally in linux omap pm branch
> smartreflex driver.  Major contributors to this driver are
> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
> Nishant Menon, Kevin Hilman.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

> +/*
> + * Omap3630 specific VP register values. Maybe these need to come from
> + * board file or PMIC data structure
> + */
> +#define OMAP3630_VP1_VLIMITTO_VDDMIN		0x18
> +#define OMAP3630_VP1_VLIMITTO_VDDMAX		0x3C
> +#define OMAP3630_VP2_VLIMITTO_VDDMIN		0x18
> +#define OMAP3630_VP2_VLIMITTO_VDDMAX		0x30
> +
> +/* TODO OMAP4 VP register values if the same file is used for OMAP4*/
> +
> +/**
> + * voltagedomain - omap voltage domain global structure
> + * @name       : Name of the voltage domain which can be used as a unique
> + *               identifier.
> + */
> +struct voltagedomain {
> +	char *name;
> +};

Minor: to keep the voltagedomain stuff somewhat separate from the rest
of the voltage layer API, I suggest putting the voltage domain APIs
here:

struct voltagedomain *omap_voltage_domain_get(char *name);

However, I think this function shoul be called _lookup instead of _get
to continue the naming conventions of the powerdomain and clockdomain
code.

Kevin


