From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/3] ARM: hwmod: RTC: Add lock and unlock functions
Date: Thu, 23 Jul 2015 12:27:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507231226350.29543@utopia.booyaka.com>
References: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
 <1437133833-32355-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="843723315-1677795593-1437654423=:29543"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437133833-32355-2-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1677795593-1437654423=:29543
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Fri, 17 Jul 2015, Lokesh Vutla wrote:

> RTC IP have kicker feature which prevents spurious writes to its register=
s.
> In order to write into any of the RTC registers, KICK values has to be
> written to KICK registers.
> Introduce omap_hwmod_rtc_unlock/lock functions, which  writes into these
> KICK registers inorder to lock and unlock RTC registers.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Please add kerneldoc for the omap_hwmod_rtc_lock() function.

- Paul


> ---
>  arch/arm/mach-omap2/omap_hwmod.h       |  2 ++
>  arch/arm/mach-omap2/omap_hwmod_reset.c | 56 ++++++++++++++++++++++++++++=
++++++
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_=
hwmod.h
> index c697b57..173a31e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.h
> +++ b/arch/arm/mach-omap2/omap_hwmod.h
> @@ -748,6 +748,8 @@ const char *omap_hwmod_get_main_clk(struct omap_hwmod=
 *oh);
>   */
> =20
>  extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
> +void omap_hwmod_rtc_unlock(struct omap_hwmod *oh);
> +void omap_hwmod_rtc_lock(struct omap_hwmod *oh);
> =20
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
> diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2=
/omap_hwmod_reset.c
> index 65e186c..eebadb2 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_reset.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
> @@ -29,6 +29,16 @@
>  #include <sound/aess.h>
> =20
>  #include "omap_hwmod.h"
> +#include "common.h"
> +
> +#define OMAP_RTC_STATUS_REG=090x44
> +#define OMAP_RTC_KICK0_REG=090x6c
> +#define OMAP_RTC_KICK1_REG=090x70
> +
> +#define OMAP_RTC_KICK0_VALUE=090x83E70B13
> +#define OMAP_RTC_KICK1_VALUE=090x95A4F1E0
> +#define OMAP_RTC_STATUS_BUSY=09BIT(0)
> +#define OMAP_RTC_MAX_READY_TIME=0950
> =20
>  /**
>   * omap_hwmod_aess_preprogram - enable AESS internal autogating
> @@ -51,3 +61,49 @@ int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
> =20
>  =09return 0;
>  }
> +
> +/**
> + * omap_rtc_wait_not_busy - Wait for the RTC BUSY flag
> + * @oh: struct omap_hwmod *
> + *
> + * For updating certain RTC registers, the MPU must wait
> + * for the BUSY status in OMAP_RTC_STATUS_REG to become zero.
> + * Once the BUSY status is zero, there is a 15-=CE=BCs access
> + * period in which the MPU can program.
> + */
> +static void omap_rtc_wait_not_busy(struct omap_hwmod *oh)
> +{
> +=09int i;
> +
> +=09/* BUSY may stay active for 1/32768 second (~30 usec) */
> +=09omap_test_timeout(omap_hwmod_read(oh, OMAP_RTC_STATUS_REG)
> +=09=09=09  & OMAP_RTC_STATUS_REG, OMAP_RTC_MAX_READY_TIME, i);
> +=09/* now we have ~15 usec to read/write various registers */
> +}
> +
> +/**
> + * omap_hwmod_rtc_unlock - Unlock the Kicker mechanism.
> + * @oh: struct omap_hwmod *
> + *
> + * RTC IP have kicker feature.  This prevents spurious writes to its reg=
isters.
> + * In order to write into any of the RTC registers, KICK values has te b=
e
> + * written in respective KICK registers. This is needed for hwmod to wri=
te into
> + * sysconfig register.
> + */
> +void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
> +{
> +=09local_irq_disable();
> +=09omap_rtc_wait_not_busy(oh);
> +=09omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
> +=09omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
> +=09local_irq_enable();
> +}
> +
> +void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
> +{
> +=09local_irq_disable();
> +=09omap_rtc_wait_not_busy(oh);
> +=09omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
> +=09omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
> +=09local_irq_enable();
> +}
> --=20
> 2.1.4
>=20


- Paul
--843723315-1677795593-1437654423=:29543
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-1677795593-1437654423=:29543--
