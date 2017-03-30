From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv3] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Thu, 30 Mar 2017 18:24:02 -0500
Message-ID: <20170330232402.o4jslzlw3kgfnjqz@rob-hp-laptop>
References: <20170327032513.22890-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170327032513.22890-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Mar 26, 2017 at 08:25:13PM -0700, Tony Lindgren wrote:
> The custom CPCAP PMIC used on Motorola phones such as Droid 4 has a
> USB battery charger. It can optionally also have a companion chip that
> is used for wireless charging.
> 
> The charger on CPCAP also can feed VBUS for the USB host mode. This
> can be handled by the existing kernel phy_companion interface.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v2:
> 
> - Update binding based on comments by Sebastian Reichel <sre@kernel.org>
> 
> - Drop "motorola,cpcap-charger" compatible for now as this seems specific
>   to the motorola-mapphone
> 
> - Update Kconfig for "depends on IIO" and "default MFD_CPCAP"
> 
> Changes since v1:
> 
> - Fix scaling of IIO values as pointed out by Sebastian Reichel
>   <sre@kernel.org>
> 
> - Use iio_read_channel_processed() instead of iio_read_channel_scaled()
>   as changed in the v2 of the ADC driver
> 
> - Add GPL v2 license header
> 
> ---
>  .../bindings/power/supply/cpcap-charger.txt        |  38 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/supply/Kconfig                       |   8 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/cpcap-charger.c               | 681 +++++++++++++++++++++
>  4 files changed, 728 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
>  create mode 100644 drivers/power/supply/cpcap-charger.c
