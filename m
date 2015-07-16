From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] ARM: DRA: hwmod: RTC: Add lock and unlock
 functions
Date: Thu, 16 Jul 2015 00:13:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160007550.32764@utopia.booyaka.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
 <1433928386-24891-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-986129763-1437005598=:32764"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1433928386-24891-3-git-send-email-lokeshvutla@ti.com>
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

--843723315-986129763-1437005598=:32764
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,=20

some comments.

On Wed, 10 Jun 2015, Lokesh Vutla wrote:

> RTC IP have kicker feature which prevents spurious writes to its register=
s.
> In order to write into any of the RTC registers, KICK values has to be
> written to KICK registers.
>=20
> Introduce omap_hwmod_rtc_unlock/lock functions, which  writes into these
> KICK registers inorder to lock and unlock RTC registers.
> Also hook these functions to RTC hwmod.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.h          |  2 ++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  2 ++
>  arch/arm/mach-omap2/omap_hwmod_reset.c    | 47 +++++++++++++++++++++++++=
++++++
>  3 files changed, 51 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_=
hwmod.h
> index 44c7db9..04855ab 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.h
> +++ b/arch/arm/mach-omap2/omap_hwmod.h
> @@ -742,6 +742,8 @@ const char *omap_hwmod_get_main_clk(struct omap_hwmod=
 *oh);
>   */
> =20
>  extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
> +void omap_hwmod_rtc_unlock(struct omap_hwmod *oh);
> +void omap_hwmod_rtc_lock(struct omap_hwmod *oh);
> =20
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-om=
ap2/omap_hwmod_7xx_data.c
> index 0e64c2f..983042f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1548,6 +1548,8 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtc=
ss_sysc =3D {
>  static struct omap_hwmod_class dra7xx_rtcss_hwmod_class =3D {
>  =09.name=09=3D "rtcss",
>  =09.sysc=09=3D &dra7xx_rtcss_sysc,
> +=09.unlock=09=3D &omap_hwmod_rtc_unlock,
> +=09.lock=09=3D &omap_hwmod_rtc_lock,
>  };
> =20
>  /* rtcss */

Is the DRA7xx the only chip that has this lock/unlock feature, or do other=
=20
OMAP chips use the same RTC IP block?

> diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2=
/omap_hwmod_reset.c
> index 65e186c..1fb106d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_reset.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
> @@ -25,11 +25,20 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> +#include <linux/delay.h>
> =20
>  #include <sound/aess.h>
> =20
>  #include "omap_hwmod.h"
> =20
> +#define OMAP_RTC_STATUS_REG=090x44
> +#define OMAP_RTC_KICK0_REG=090x6c
> +#define OMAP_RTC_KICK1_REG=090x70
> +
> +#define OMAP_RTC_KICK0_VALUE=090x83E70B13
> +#define OMAP_RTC_KICK1_VALUE=090x95A4F1E0
> +#define OMAP_RTC_STATUS_BUSY=09BIT(0)
> +
>  /**
>   * omap_hwmod_aess_preprogram - enable AESS internal autogating
>   * @oh: struct omap_hwmod *
> @@ -51,3 +60,41 @@ int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
> =20
>  =09return 0;
>  }
> +
> +static void omap_rtc_wait_not_busy(struct omap_hwmod *oh)

This function is missing kerneldoc and desperately needs it.

> +{
> +=09int count;
> +=09u8 status;
> +
> +=09/* BUSY may stay active for 1/32768 second (~30 usec) */
> +=09for (count =3D 0; count < 50; count++) {

OK, I give up.  Where does 50 come from?  This should be moved into a=20
macro with a comment, at the very least.

> +=09=09status =3D omap_hwmod_read(oh, OMAP_RTC_STATUS_REG);
> +=09=09if (!(status & OMAP_RTC_STATUS_BUSY))
> +=09=09=09break;
> +=09=09udelay(1);
> +=09}
> +=09/* now we have ~15 usec to read/write various registers */
> +}
> +
> +/**
> + * omap_hwmod_rtc_unlock - Reset and unlock the Kicker mechanism.
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
> +=09omap_rtc_wait_not_busy(oh);

What prevents the CPU from context-switching away after the BUSY bit test=
=20
and not returning back here by the time the ~15 =B5s interval has ended? =
=20
Looks to me like this whole thing needs to run with interrupts disabled.

> +=09omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
> +=09omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
> +}
> +
> +void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
> +{
> +=09omap_rtc_wait_not_busy(oh);

Same comment as the above.

> +=09omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
> +=09omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
> +}
> --=20
> 1.9.1
>=20


- Paul
--843723315-986129763-1437005598=:32764
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-986129763-1437005598=:32764--
