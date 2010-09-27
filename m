From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 0/5] Convert I2C driver to use omap_device/runtime PM
Date: Mon, 27 Sep 2010 13:02:47 -0700
Message-ID: <87vd5rnee0.fsf@deeprootsystems.com>
References: <1285078036-12789-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1285078036-12789-1-git-send-email-rnayak@ti.com> (Rajendra
	Nayak's message of "Tue, 21 Sep 2010 19:37:11 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ben-linux@fluff.org
Cc: Rajendra Nayak <rnayak@ti.com>, linux-i2c@vger.kernel.org, khali@linux-fr.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Ben,

Rajendra Nayak <rnayak@ti.com> writes:

> This series makes I2C device registration use hwmod and omap_device api's
> and converts the I2C driver to use runtime PM api's.
>
> Patches apply on the pm-core branch from Kevin's tree.

If you're OK with the driver changes in PATCH 5/5, with your Ack, we can
queue this via the OMAP tree with all the platform changes that it
depends on.

Thanks,

Kevin

> v3 has minor review comment fixes over v2
> The series is boot tested on a 2430sdp platform along with being tested
> on 3430sdp and 4430sdp.
>
> 4430sdp tests are done using the below series 
> http://www.spinics.net/lists/linux-omap/msg36023.html
>
> Paul Walmsley (2):
>   OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
>   OMAP: I2C: split device registration and convert OMAP2+ to
>     omap_device
>
> Rajendra Nayak (3):
>   OMAP3: hwmod: add I2C hwmods for OMAP3430
>   OMAP4: hwmod: add I2C hwmods for OMAP4430
>   OMAP: I2C: Convert i2c driver to use PM runtime api's
>
>  arch/arm/mach-omap2/cm-regbits-24xx.h      |    4 +
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  140 ++++++++++++++++-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  154 ++++++++++++++++++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  232 +++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  237 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prm-regbits-34xx.h     |    3 +
>  arch/arm/plat-omap/i2c.c                   |  124 ++++++---------
>  arch/arm/plat-omap/include/plat/i2c.h      |   16 ++
>  arch/arm/plat-omap/include/plat/l4_3xxx.h  |   24 +++
>  drivers/i2c/busses/i2c-omap.c              |   67 +++------
>  include/linux/i2c-omap.h                   |    5 +
>  11 files changed, 881 insertions(+), 125 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/l4_3xxx.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
