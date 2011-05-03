From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/7] OMAP: DSS: Adding a header file for picodlp
 panel data
Date: Tue, 03 May 2011 21:33:31 +0300
Message-ID: <1304447611.26126.27.camel@deskari>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
	 <1304347971-1504-2-git-send-email-mayur@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55921 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262Ab1ECSdg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 14:33:36 -0400
Received: by mail-ew0-f53.google.com with SMTP id 8so122845ewy.12
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 11:33:34 -0700 (PDT)
In-Reply-To: <1304347971-1504-2-git-send-email-mayur@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mayuresh Janorkar <mayur@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-05-02 at 20:22 +0530, Mayuresh Janorkar wrote:
> picodlp is a TI projector panel supported by OMAP
> picodlp makes use of i2c interface for transferring commands to the panel
> panel data is required for identifying i2c_adapter id and dlp GPIOs
> 
> A new header file has been added for panel data and
> picodlp_panel_data struct has been introduced
> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> ---
> Changes since v1: Nil
> 
>  arch/arm/plat-omap/include/plat/panel-picodlp.h |   25 +++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/panel-picodlp.h
> 
> diff --git a/arch/arm/plat-omap/include/plat/panel-picodlp.h b/arch/arm/plat-omap/include/plat/panel-picodlp.h
> new file mode 100644
> index 0000000..89ac4b9
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/panel-picodlp.h
> @@ -0,0 +1,25 @@
> +/*
> + * panel data for picodlp panel
> + *
> + * Copyright (C) 2011 Texas Instruments
> + *
> + * Author: Mayuresh Janorkar <mayur@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ARCH_ARM_PLAT_PANEL_PICODLP_H
> +#define __ARCH_ARM_PLAT_PANEL_PICODLP_H
> +/**
> + * struct : picodlp panel data
> + * picodlp_adapter_id:	i2c_adapter number for picodlp
> + */
> +struct picodlp_panel_data {
> +	int picodlp_adapter_id;
> +	int phy_reset_gpio;
> +	int ready_reset_gpio;
> +	int park_gpio;
> +	int display_sel_gpio;
> +};

I think I've asked this before: where do the names of the GPIOs come
from? I can't find them from the documentation.

 Tomi


