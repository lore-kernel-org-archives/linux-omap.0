From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 2/5] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 18 Mar 2011 09:34:39 +0100
Message-ID: <201103180934.39997.arnd@arndb.de>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com> <20110312225047.27728.1835.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54694 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab1CRIey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 04:34:54 -0400
In-Reply-To: <20110312225047.27728.1835.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Andy Green <andy.green@linaro.org>

On Saturday 12 March 2011, Andy Green wrote:
> Introduce a generic helper function that can set a MAC address using
> data from the OMAP unqiue CPU ID register.
> 
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
> 
>  arch/arm/mach-omap2/id.c              |   13 +++++++++++++
>  arch/arm/mach-omap2/include/mach/id.h |    1 +
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5f9086c..fc69ec5 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -506,3 +506,16 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
>         else
>                 tap_prod_id = 0x0208;
>  }
> +
> +
> +void omap2_die_id_to_mac(u8 *mac, int length)
> +{
> +       struct omap_die_id odi;
> +
> +       omap_get_die_id(&odi);
> +       memcpy(mac, &odi.id_0, length);
> +
> +       /* mark it as not multicast and outside official 80211 MAC namespace */
> +
> +       mac[0] = (mac[0] & ~1) | 2;
> +}

This is a pretty clever trick, but it's not an official globally unique MAC
address, right? Maybe we can ask TI to officially request a MAC address range
for OMAP SoCs and document an official procedure to compute it.

	Arnd
