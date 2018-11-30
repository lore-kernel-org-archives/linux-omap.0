From: Dimitar Dimitrov <dinuxbg@gmail.com>
Subject: Re: [PATCH 04/16] remoteproc/pru: Add PRU remoteproc driver
Date: Fri, 30 Nov 2018 23:39:48 +0200
Message-ID: <308735274.C9ZyqtqOL8@tpdeb>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com> <1543218769-5507-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543218769-5507-5-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: ohad@wizery.com, bjorn.andersson@linaro.org, tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday, 12/26/2018, 9:52:37 EET Roger Quadros wrote:
> +/*
> + * Convert PRU device address (instruction space) to kernel virtual address
> + *
> + * A PRU does not have an unified address space. Each PRU has its very own
> + * private Instruction RAM, and its device address is identical to that of
> + * its primary Data RAM device address.
> + */
> +static void *pru_i_da_to_va(struct pru_rproc *pru, u32 da, int len)
> +{
> +       u32 offset;
> +       void *va = NULL;
> +
> +       if (len <= 0)
> +               return NULL;

Could you please clear the upper 4 bits the of IRAM device address, in order 
to support binutils ELF images? Here is an example line to add here:

+       /* GNU binutils do not support multiple address spaces. The 
+        * default linker script from the official GNU pru-ld places 
+        * IRAM at an arbitrary high offset, in order to differentiate it 
+        * from DRAM. Hence we need to strip the artificial offset 
+        * from the IRAM address. 
+        */ 
+       da &= ~0xf0000000u; 
+


> +
> +       if (da >= pru->iram_da &&
> +           da + len <= pru->iram_da + pru->mem_regions[PRU_MEM_IRAM].size { 
> +               offset = da - pru->iram_da;
> +               va = (__force void *)(pru->mem_regions[PRU_MEM_IRAM].va +
> +                                     offset);
> +       }
> +
> +       return va;
> +}
