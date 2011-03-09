From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: Re: [PATCH 2 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality
 flags for each cpu_... test
Date: Wed, 9 Mar 2011 20:03:17 +0530
Message-ID: <AANLkTimTnEuH=H0w96dZLmqYPhGM2dN168JViC8wciuV@mail.gmail.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
	<20110308110904.23531.66727.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50341 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757054Ab1CIOdT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 09:33:19 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so491839vws.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 06:33:18 -0800 (PST)
In-Reply-To: <20110308110904.23531.66727.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

On Tue, Mar 8, 2011 at 4:39 PM, Andy Green <andy@warmcat.com> wrote:
> +/* struct omap_i2c_bus_platform_data .flags meanings */
> +
> +#define OMAP_I2C_FLAG_NO_FIFO 1
Hi,

Minor comment, Can you use
BIT(0) for 1, BIT(1) for 2 ... BIT (8) for 0x100

> +#define OMAP_I2C_FLAG_SIMPLE_CLOCK 2
> +#define OMAP_I2C_FLAG_16BIT_DATA_REG 4
> +#define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE 8
> +#define OMAP_I2C_FLAG_APPLY_ERRATA_I207 0x10
> +#define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK 0x20
