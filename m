From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address
 space
Date: Thu, 15 Dec 2011 23:28:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com> <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-594604338-1324016894=:12660"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49500 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab1LPG2Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 01:28:16 -0500
In-Reply-To: <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-594604338-1324016894=:12660
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt

On Mon, 28 Nov 2011, Peter Ujfalusi wrote:

> To be able to get the memory resources by name from
> the DMIC driver (for MPU and for DMA).

Any comments on this one?  Looks like we'd need to add these names as=20
hints in the script.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
> index 7695e5d..8b75c60 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1028,6 +1028,7 @@ static struct omap_hwmod_dma_info omap44xx_dmic_sdm=
a_reqs[] =3D {
> =20
>  static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] =3D {
>  =09{
> +=09=09.name=09=09=3D "mpu",
>  =09=09.pa_start=09=3D 0x4012e000,
>  =09=09.pa_end=09=09=3D 0x4012e07f,
>  =09=09.flags=09=09=3D ADDR_TYPE_RT
> @@ -1046,6 +1047,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__dm=
ic =3D {
> =20
>  static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] =3D {
>  =09{
> +=09=09.name=09=09=3D "dma",
>  =09=09.pa_start=09=3D 0x4902e000,
>  =09=09.pa_end=09=09=3D 0x4902e07f,
>  =09=09.flags=09=09=3D ADDR_TYPE_RT



- Paul
--155748971-594604338-1324016894=:12660--
