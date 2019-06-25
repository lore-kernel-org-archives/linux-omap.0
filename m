From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH V3 01/15] arm: perf: cleanup cppcheck shifting error
Date: Tue, 25 Jun 2019 18:21:07 +0100
Message-ID: <20190625172106.26xxbeiwpn4avykh@willie-the-truck>
References: <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190625040356.27473-1-tranmanphong@gmail.com>
 <20190625040356.27473-2-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190625040356.27473-2-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 25, 2019 at 11:03:42AM +0700, Phong Tran wrote:
> There is error from cppcheck tool
> "Shifting signed 32-bit value by 31 bits is undefined behaviour errors"
> change to use BIT() marco for improvement.

s/marco/macro/

As Peter pointed out, this "error" is also a false positive also for the
kernel.

> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm/kernel/perf_event_v7.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index a4fb0f8b8f84..2924d7910b10 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -697,9 +697,9 @@ static struct attribute_group armv7_pmuv2_events_attr_group = {
>  /*
>   * Event filters for PMUv2
>   */
> -#define	ARMV7_EXCLUDE_PL1	(1 << 31)
> -#define	ARMV7_EXCLUDE_USER	(1 << 30)
> -#define	ARMV7_INCLUDE_HYP	(1 << 27)
> +#define	ARMV7_EXCLUDE_PL1	BIT(31)
> +#define	ARMV7_EXCLUDE_USER	BIT(30)
> +#define	ARMV7_INCLUDE_HYP	BIT(27)

Acked-by: Will Deacon <will.deacon@arm.com>

You can drop this into Russell's patch system[1].

Will

[1] https://www.arm.linux.org.uk/developer/patches/
