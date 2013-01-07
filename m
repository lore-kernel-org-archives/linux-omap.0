From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] capemgr: Beaglebone DT overlay based cape manager
Date: Mon, 7 Jan 2013 12:09:46 -0800
Message-ID: <20130107200945.GF14149@atomide.com>
References: <1357584666-17374-1-git-send-email-panto@antoniou-consulting.com>
 <1357584666-17374-2-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357584666-17374-2-git-send-email-panto@antoniou-consulting.com>
Sender: linux-doc-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jon Loeliger <jdl@jdl.com>, Stephen Warren <swarren@wwwdotorg.org>, David Gibson <david@gibson.dropbear.id.au>, Benoit Cousson <b-cousson@ti.com>, Mitch Bradley <wmb@firmworks.com>, Alan Tull <atull@altera.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [130107 10:54]:
> A cape loader based on DT overlays and DT objects.
> 
> Beaglebone cape manager implementation.
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
>  arch/arm/mach-omap2/Kconfig            |    2 +
>  drivers/misc/Kconfig                   |    2 +
>  drivers/misc/Makefile                  |    1 +
>  drivers/misc/cape/Kconfig              |    5 +
>  drivers/misc/cape/Makefile             |    5 +
>  drivers/misc/cape/beaglebone/Kconfig   |   11 +
>  drivers/misc/cape/beaglebone/Makefile  |    5 +
>  drivers/misc/cape/beaglebone/capemgr.c | 1835 ++++++++++++++++++++++++++++++++

The driver should probably be in drivers/bus?

>  8 files changed, 1866 insertions(+)
>  create mode 100644 drivers/misc/cape/Kconfig
>  create mode 100644 drivers/misc/cape/Makefile
>  create mode 100644 drivers/misc/cape/beaglebone/Kconfig
>  create mode 100644 drivers/misc/cape/beaglebone/Makefile
>  create mode 100644 drivers/misc/cape/beaglebone/capemgr.c
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 41b581f..f0c2eab 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -18,6 +18,8 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>  	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
>  	select VFP
> +	select OF_OVERLAY
> +	select OF_RESOLVE
>  	help
>  	  Compile a kernel suitable for booting most boards

You should just make the driver depend on OF_OVERLAY and
OF_RESOLVE as most SoCs won't need this. Then we can select
it in the omap2plus_defconfig.

Regards,

Tony  
