From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 00/13] MFD: twl drivers: Convert to regmap IO and cleanups
Date: Wed, 21 Nov 2012 15:54:09 +0100
Message-ID: <20121121145409.GY18738@sortiz-mobl>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Tue, Nov 13, 2012 at 09:28:41AM +0100, Peter Ujfalusi wrote:
> Hello,
> 
> This series converts the twl-core to use regmap for IO towards the chip.
> With the conversion to regmap IO we no longer need to allocate bigger buffer for
> writes.
> I have appended patches to this series to make some cleanups which will help in
> the future to further clean up the twl stack.
> 
> The series depends on a regression fix patch for the twl-core:
> https://patchwork.kernel.org/patch/1679421/
> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (13):
>   MFD: twl-core: Register twl4030-madc child only for twl4030 class
>   MFD: twl-core: Support for proper PWM drivers
>   MFD: twl-core: Convert to use regmap for I/O
>   MFD/rtc/gpio: twl: No need to allocate bigger buffer for write
>   MFD: twl-core: Clean up and correct child registration
>   mfd: twl: Remove unused TWL_MODULE definitions
>   mfd: twl: Convert module id definitions to enums
>   mfd: twl: Use decimal numbers for TWL6030_MODULE_IDs
>   MFD: twl-core: re-group the twl_mapping table for easier reading
>   mfd: twl4030-madc: Change TWL4030_MODULE_* ids to TWL_MODULE_*
>   mfd: twl4030-power: Change TWL4030_MODULE_* ids to TWL_MODULE_*
>   mfd: twl4030-irq: Change TWL4030_MODULE_* ids to TWL_MODULE_*
>   mfd: twl-core: Change TWL4030_MODULE_* ids to TWL_MODULE_*
All patches applied now, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
