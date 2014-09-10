From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 0/3] OMAP4+: Get rid of internal SRAM handling
Date: Wed, 10 Sep 2014 11:56:43 -0500
Message-ID: <20140910165643.GA3118@splat>
References: <cover.1410362895.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1410362895.git.d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11:04-20140910, Dave Gerlach wrote:
> v3:
> Fix minor issue in last patch to check for null sram_pool if no sram
> phandle is given in DT.
> 
> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
> use drivers/misc/sram.c driver instead of the omap internal
> implementation for SRAM handling.
> 
> Previous discussion can be found at [1].
> 
> Regards,
> Dave
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/195588.html
> 
> Rajendra Nayak (3):
>   ARM: AM335x: Get rid of unused sram init function
>   ARM: OMAP4+: Move SRAM data to DT
>   ARM: OMAP4+: Remove static iotable mappings for SRAM
> 
>  Documentation/devicetree/bindings/arm/omap/mpu.txt |  3 ++
>  arch/arm/boot/dts/am33xx.dtsi                      |  5 ++-
>  arch/arm/boot/dts/am4372.dtsi                      |  5 +++
>  arch/arm/boot/dts/omap4.dtsi                       |  6 ++++
>  arch/arm/boot/dts/omap5.dtsi                       |  8 ++++-
>  arch/arm/configs/omap2plus_defconfig               |  1 +
>  arch/arm/mach-omap2/io.c                           | 17 ----------
>  arch/arm/mach-omap2/omap4-common.c                 | 22 +++++++++++-
>  arch/arm/mach-omap2/sram.c                         | 39 +---------------------
>  arch/arm/mach-omap2/sram.h                         |  7 ----
>  10 files changed, 46 insertions(+), 67 deletions(-)
> 

Could you please provide logs for the following:
a) Low power transition tests for OMAP3,4 on all available platforms as
well?
b) provide bootlogs on all omap2plus platforms to ensure we have no
regressions.

-- 
Regards,
Nishanth Menon
