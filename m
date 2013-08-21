From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add new bindings for OMAP
Date: Wed, 21 Aug 2013 00:45:14 -0700
Message-ID: <20130821074514.GU7656@atomide.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com>
 <1376983966-16490-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376983966-16490-3-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: bcousson@baylibre.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Rajendra Nayak <rnayak@ti.com> [130820 00:41]:
> On OMAP we have co-processor IPs, memory controllers,
> GPIOs which control regulators and power switches to
> PMIC, and SoC internal Bus IPs, some or most of which
> should either not be reset or idled or both. Have a
> way to pass this information from DT.
> (In some cases there are erratas which prevent an IPs
> from being reset)
> 
> Also update omap_hwmod to extract this from DT.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |    3 ++-
>  arch/arm/mach-omap2/omap_hwmod.c                   |   22 +++++++++++++-------
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 6d498c7..a08647e 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -21,7 +21,8 @@ Required properties:
>  Optional properties:
>  - ti,no_idle_on_suspend: When present, it prevents the PM to idle the module
>    during suspend.
> -
> +- ti,no-reset: When present, the module should not be reset
> +- ti,no-idle: When present, the module should not be idled

This naming is a bit confusing as people may think that the
hardware has no reset support or no idle support. Let's try
to make this to describe the hardware a bit more instead.

Then ideally we'd not map individual bits of data to properties,
but describe few basic types of hardware instead and build
lists of things instead of tagging things. Or maybe we
can get this data from the bus hierarchy instead?

If these options don't work, and the choice may be board
specific, then how about ti,skip-reset-on-init, and
ti,skip-idle-on-init?

Regards,

Tony
