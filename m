From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 0/5] Input: pixcir_i2c_ts: Add Type-B Multi-touch and
 DT support
Date: Thu, 3 Jul 2014 12:34:38 +0300
Message-ID: <53B523AE.70601@ti.com>
References: <1402997507-9736-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402997507-9736-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, tony@atomide.com
Cc: rydberg@euromail.se, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, nsekhar@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

Gentle reminder to pick this series for -next. Thanks :).

cheers,
-roger

On 06/17/2014 12:31 PM, Roger Quadros wrote:
> Hi Dmitry,
> 
> These are the pending patches that didn't go through in the 3.16 merge window.
> Please queue them for -next. Thanks.
> 
> The series does the following
> - convert to Type-B multi touch protocol
> - support upto 5 fingers with hardware supplied tracking IDs
> - device tree support
> 
> Tony,
> 
> The last 2 patches fix the touch screen size property in the device tree since
> we now use the unified touch screen properties.
> 
> cheers,
> -roger
> 
> Changelog:
> 
> v7:
> - Rebased on 3.16-rc1.
> 
> v6:
> - Use unified touchscreen bindings.
> - Update pointer math i.e. bufptr += 4 instead of &bufptr[4];
> 
> v5:
> - Changed ts->exiting flag to ts->running in patch 2.
> - Don't call pixcir_stop() from .suspend() if wakeup is required.
> 
> v4:
> - Imporved pixcir_stop() as per Dmitry's suggestion.
> - Removed unnecessary input_unregister_device() from .remove().
> 
> v3:
> - Rebased to 3.15-rc3
> - Fixed suspend while touchscreen in use
> - Fixed module removal while touchscreen in use
> 
> v2:
> - Addressed review comments and re-arranged patch order
> 
> v1:
> - http://article.gmane.org/gmane.linux.kernel/1616417
> 
> --
> 
> Roger Quadros (5):
>   Input: pixcir_i2c_ts: Use Type-B Multi-Touch protocol
>   Input: pixcir_i2c_ts: support upto 5 fingers and hardware provided
>     tracking IDs
>   Input: pixcir_i2c_ts: Add device tree support
>   ARM: dts: am43x-epos-evm: Update binding for touchscreen size
>   ARM: dts: am437x-gp-evm: Update binding for touchscreen size
> 
>  .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  26 +++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/am437x-gp-evm.dts                |   4 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts               |   4 +-
>  drivers/input/touchscreen/pixcir_i2c_ts.c          | 251 ++++++++++++++++++---
>  include/linux/input/pixcir_ts.h                    |  12 +
>  6 files changed, 259 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> 
