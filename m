From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap dts updates for v4.9 merge window, part 2
Date: Mon, 19 Sep 2016 17:45:00 +0200
Message-ID: <2566941.uVvDnvgHof@wuerfel>
References: <20160915172021.6u2zam4yd6vruub4@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160915172021.6u2zam4yd6vruub4@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday, September 15, 2016 10:20:22 AM CEST Tony Lindgren wrote:
> Part two of device tree changes for omaps for v4.9 merge window. This
> is mostly usability and non-critical fixes except for the addition of
> beagleboard-x15 rev B1 support:
> 
> - Fix omap4 pandaboard SDIO WLAN latencies in idle mode by enabling wakeirq
> 
> - Usability fixes for WLAN, USB, LEDs and power button on omap5 boards
> 
> - Remove am57xx beagleboard-x15 pinmux configuration as the processor requires
>   that it's done in IO isolation in bootloader except for MMC and DCAN
> 
> - Add support for beagleboard-x15 rev B1 by moving most of the
>   configuration to am57xx-beagle-x15-common.dtsi
> 
> - Enable support for more than 2GB of memory for omap5 with LPAE with
>   #address-cells
> 
> - Fix omap3-gta04 backlight PWM frequency until the PWM driver
> 
> - Revert am335x dts changes related to cpufreq as the driver changes
>   still have not merged and the dts changes broke cpufreq

Pulled into next/dt, thanks!

	Arnd
