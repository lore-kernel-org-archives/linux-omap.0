From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: hwmod_data: Name the common irq for
 McBSP ports
Date: Wed, 4 Apr 2012 09:46:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040946230.8000@utopia.booyaka.com>
References: <1332169966-25400-1-git-send-email-peter.ujfalusi@ti.com> <1332169966-25400-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-222532944-1333554411=:8000"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33529 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab2DDPqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 11:46:51 -0400
In-Reply-To: <1332169966-25400-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-222532944-1333554411=:8000
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

+ Beno=EEt

Hi Beno=EEt

On Mon, 19 Mar 2012, Peter Ujfalusi wrote:

> Use 'common' as name for the common irq number in hwmod data for the McBS=
P
> ports. The same name already in use for OMAP2430, and OMAP3.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

care to Ack this one for 3.5?


- Paul


> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
> index ef0524c..f8058b7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2942,7 +2942,7 @@ static struct omap_hwmod_class omap44xx_mcbsp_hwmod=
_class =3D {
>  /* mcbsp1 */
>  static struct omap_hwmod omap44xx_mcbsp1_hwmod;
>  static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] =3D {
> -=09{ .irq =3D 17 + OMAP44XX_IRQ_GIC_START },
> +=09{ .name =3D "common", .irq =3D 17 + OMAP44XX_IRQ_GIC_START },
>  =09{ .irq =3D -1 }
>  };
> =20
> @@ -3017,7 +3017,7 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod =3D =
{
>  /* mcbsp2 */
>  static struct omap_hwmod omap44xx_mcbsp2_hwmod;
>  static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] =3D {
> -=09{ .irq =3D 22 + OMAP44XX_IRQ_GIC_START },
> +=09{ .name =3D "common", .irq =3D 22 + OMAP44XX_IRQ_GIC_START },
>  =09{ .irq =3D -1 }
>  };
> =20
> @@ -3092,7 +3092,7 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod =3D =
{
>  /* mcbsp3 */
>  static struct omap_hwmod omap44xx_mcbsp3_hwmod;
>  static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] =3D {
> -=09{ .irq =3D 23 + OMAP44XX_IRQ_GIC_START },
> +=09{ .name =3D "common", .irq =3D 23 + OMAP44XX_IRQ_GIC_START },
>  =09{ .irq =3D -1 }
>  };
> =20
> @@ -3167,7 +3167,7 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod =3D =
{
>  /* mcbsp4 */
>  static struct omap_hwmod omap44xx_mcbsp4_hwmod;
>  static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] =3D {
> -=09{ .irq =3D 16 + OMAP44XX_IRQ_GIC_START },
> +=09{ .name =3D "common", .irq =3D 16 + OMAP44XX_IRQ_GIC_START },
>  =09{ .irq =3D -1 }
>  };
> =20
> --=20
> 1.7.8.5
>=20


- Paul
--155748971-222532944-1333554411=:8000--
