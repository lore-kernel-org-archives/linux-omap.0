From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] MFD: Change TWL6025 references to TWL6032
Date: Thu, 20 Jun 2013 10:27:41 +0200
Message-ID: <20130620082741.GB15667@zurbaran>
References: <1371644642-934-1-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371644642-934-1-git-send-email-oleksandr.kozaruk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, t-kristo@ti.com, gg@slimlogic.co.uk, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Oleksandr,

On Wed, Jun 19, 2013 at 03:24:02PM +0300, Oleksandr Kozaruk wrote:
> From: Graeme Gregory <gg@slimlogic.co.uk>
> 
> The TWL6025 was never released beyond sample form and was replaced by
> the PhoenixLite range of chips - TWL6032. Change the references to
> reference the TWL6032 class and name the registers to twl6032 in line with
> an actual released chip name to avoid confusion.
> 
> Currently there are no users of TWL6025 in the code.
> 
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> ---
> 
> There are non-mainline branches that use twl6032 by its name (for example
> git://git.omapzoom.org/kernel/omap.git). There is intention to add support
> of twl6032 device in mainline, but we'd like to know if we can use twl6032
> instead of twl6025 in our new patches, that we are going to provide.
> Related discussion: https://patchwork.kernel.org/patch/2686331/
> 
>  .../bindings/regulator/twl-regulator.txt           |   26 +++----
>  .../devicetree/bindings/usb/twlxxxx-usb.txt        |    2 +-
>  drivers/mfd/twl-core.c                             |   46 ++++++------
>  drivers/regulator/twl-regulator.c                  |   76 ++++++++++----------
>  drivers/usb/phy/phy-twl6030-usb.c                  |    2 +-
>  include/linux/i2c/twl.h                            |   30 ++++----
>  6 files changed, 91 insertions(+), 91 deletions(-)
Applied to mfd-next, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
