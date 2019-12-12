From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: dts: am437x-gp-evm: add HDMI support
Date: Thu, 12 Dec 2019 09:21:04 -0800
Message-ID: <20191212172104.GY35479@atomide.com>
References: <20191125131100.9839-1-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20191125131100.9839-1-tomi.valkeinen@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [191125 05:11]:
> Add HDMI support for AM437x GP EVM. The HDMI uses SiI9022 HDMI encoder,
> and is mutually exclusive with the LCD. The choice between LCD and HDMI
> is made by booting either with am437x-gp-evm.dtb or
> am437x-gp-evm-hdmi.dtb.

So Linux kernel needs a new board device tree file to toggle a GPIO line
to switch between LCD mode and HDMI?

That does not sound very user friendly for something that's supposed
to be hot pluggabe :)

> +/* Override SelLCDorHDMI from am437x-gp-evm.dts to select HDMI */
> +&gpio5 {
> +	p8 {
> +		output-low;
> +	};
> +};

How about just leave the gpio unconfigured and document that a userspace
tool or /sys/kernel/debug/gpio is needed to toggle between the modes?

Regards,

Tony
