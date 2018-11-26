From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 09/17] soc: ti: pruss: add
 pruss_{request,release}_mem_region() API
Date: Mon, 26 Nov 2018 15:18:06 -0600
Message-ID: <bbbc5274-0ce2-3806-0a6a-c71785e7aebd@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-10-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-10-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> Add two new API - pruss_request_mem_region() & pruss_release_mem_region(),
> to the PRUSS platform driver to allow client drivers to acquire and release
> the common memory resources present within a PRU-ICSS subsystem. This
> allows the client drivers to directly manipulate the respective memories,
> as per their design contract with the associated firmware.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> [s-anna@ti.com: rename functions, add error checking, comments]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---


> diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
> index a5a0667..f8878c2 100644
> --- a/drivers/soc/ti/pruss.h
> +++ b/drivers/soc/ti/pruss.h
> @@ -22,28 +22,6 @@
>   #define MAX_PRU_HOST_INT	10
>   
>   /**
> - * enum pruss_mem - PRUSS memory range identifiers
> - */
> -enum pruss_mem {
> -	PRUSS_MEM_DRAM0 = 0,
> -	PRUSS_MEM_DRAM1,
> -	PRUSS_MEM_SHRD_RAM2,
> -	PRUSS_MEM_MAX,
> -};
> -
> -/**
> - * struct pruss_mem_region - PRUSS memory region structure
> - * @va: kernel virtual address of the PRUSS memory region
> - * @pa: physical (bus) address of the PRUSS memory region
> - * @size: size of the PRUSS memory region
> - */
> -struct pruss_mem_region {
> -	void __iomem *va;
> -	phys_addr_t pa;
> -	size_t size;
> -};

Why don't we just put these definitions in the correct header file
to start with when they are introduced earlier in this series?


> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> new file mode 100644
> index 0000000..198ae25
> --- /dev/null
> +++ b/include/linux/pruss.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * PRU-ICSS Subsystem user interfaces
> + *
> + * Copyright (C) 2015-2018 Texas Instruments Incorporated - http://www.ti.com
> + *	Suman Anna <s-anna@ti.com>
> + *	Tero Kristo <t-kristo@ti.com>
> + */
> +
> +#ifndef __LINUX_PRUSS_H
> +#define __LINUX_PRUSS_H
> +
> +/**
> + * enum pruss_mem - PRUSS memory range identifiers
> + */
> +enum pruss_mem {
> +	PRUSS_MEM_DRAM0 = 0,
> +	PRUSS_MEM_DRAM1,
> +	PRUSS_MEM_SHRD_RAM2,
> +	PRUSS_MEM_MAX,
> +};
> +
> +/**
> + * struct pruss_mem_region - PRUSS memory region structure
> + * @va: kernel virtual address of the PRUSS memory region
> + * @pa: physical (bus) address of the PRUSS memory region
> + * @size: size of the PRUSS memory region
> + */
> +struct pruss_mem_region {
> +	void __iomem *va;
> +	phys_addr_t pa;
> +	size_t size;
> +};
> +
