From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 2/8] misc: ddr: add LPDDR2 data from JESD209-2
Date: Thu, 16 Feb 2012 15:37:24 +0530
Message-ID: <4F3CD55C.2020002@ti.com>
References: <1328357771-31644-1-git-send-email-aneesh@ti.com> <1328357771-31644-3-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328357771-31644-3-git-send-email-aneesh@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Saturday 04 February 2012 05:46 PM, Aneesh V wrote:
> add LPDDR2 data from the JEDEC spec JESD209-2. The data
> includes:
> 
> 1. Addressing information for LPDDR2 memories of different
>    densities and types(S2/S4)
> 2. AC timing data.
> 
> This data will useful for memory controller device drivers
> 
> Signed-off-by: Aneesh V <aneesh@ti.com>
Sorry.. Missed one minor comment.

> ---
>  drivers/misc/Kconfig          |    8 ++
>  drivers/misc/Makefile         |    1 +
>  drivers/misc/jedec_ddr_data.c |  141 +++++++++++++++++++++++++++++++++
>  include/linux/jedec_ddr.h     |  174 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 324 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/jedec_ddr_data.c
>  create mode 100644 include/linux/jedec_ddr.h
> 

[...]

> diff --git a/drivers/misc/jedec_ddr_data.c b/drivers/misc/jedec_ddr_data.c
> new file mode 100644
> index 0000000..299c056
> --- /dev/null
> +++ b/drivers/misc/jedec_ddr_data.c
> @@ -0,0 +1,141 @@
> +/*
> + * DDR addressing details and AC timing parameters from JEDEC specs
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
Fix the year please. Should be 2012
