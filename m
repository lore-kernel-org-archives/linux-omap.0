From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] bus: ti-sysc: Add generic enable/disable functions
Date: Tue, 9 Apr 2019 08:59:18 -0700
Message-ID: <20190409155918.GL2839@atomide.com>
References: <20190408095239.30378-1-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408095239.30378-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: s-anna@ti.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190408 02:53]:
> For non legacy cases, add generic sysc_enable_module()
> and sysc_disable_module() functions.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Boot tested on
> - beagle-x15 (AM5728 GP EVM)
> - AM571x IDK
> - DRA7 EVM
> 
> Changelog:
> v2:
> - Add helper to get best idle mode.
> - Add comment about not preventing clockdomain autoidle
>   during enable/disable.
> - Omit PRU-ICSS specific handling. PRU-ICSS moudle can re-use omap4-simple.
>   The STANDBY_INIT and SUB_MWAIT bits are specific to PRUSS application
>   usage and should be managed by the PRUSS driver.

Thanks looks good to me, applying into omap-for-v5.2/ti-sysc.

Regards,

Tony
