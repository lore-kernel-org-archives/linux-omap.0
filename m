From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 00/13] MFD: twl drivers: Convert to regmap IO and
 cleanups
Date: Fri, 16 Nov 2012 16:44:20 +0200
Message-ID: <1353077060.786.18.camel@sokoban>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Peter / Samuel,

I just tested this set on omap3beagle + omap4460 panda boards and both
seem to work fine. Did a boot + simple PM test for both to see that
regulator control (which is using the I2C related stuff you have
changed) works. Also, looking at the code everything seems to be okay to
me, thus for whole set:

Acked-by: Tero Kristo <t-kristo@ti.com>

On Tue, 2012-11-13 at 09:28 +0100, Peter Ujfalusi wrote:
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
> 
>  drivers/gpio/gpio-twl4030.c |  12 +--
>  drivers/mfd/twl-core.c      | 227 +++++++++++++++++++++++---------------------
>  drivers/mfd/twl4030-irq.c   |  10 +-
>  drivers/mfd/twl4030-madc.c  |  14 +--
>  drivers/mfd/twl4030-power.c | 124 ++++++++++--------------
>  drivers/mfd/twl6030-irq.c   |   4 +-
>  drivers/rtc/rtc-twl.c       |  32 +++----
>  include/linux/i2c/twl.h     |  73 +++++++-------
>  8 files changed, 241 insertions(+), 255 deletions(-)
> 
