From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 01/19] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Fri, 25 Mar 2011 09:58:34 +0100
Message-ID: <AANLkTikSxR5P8b-TQFoCgUvuvs8sGdYbTXvZxP0_etpx@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43106 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab1CYI6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 04:58:35 -0400
Received: by qyg14 with SMTP id 14so542516qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 01:58:34 -0700 (PDT)
In-Reply-To: <1300924833-26745-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> The voltage domain pointer currently in struct omap_hwmod is not used
> and does not belong here. =A0Instead, voltage domains will be associa=
ted
Extra space

> with powerdomains in forthcoming patches.
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index 1adea9c..a5fa7c1 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -520,7 +520,6 @@ struct omap_hwmod {
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*_clk;
> =A0 =A0 =A0 =A0struct omap_hwmod_opt_clk =A0 =A0 =A0 *opt_clks;
> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*vdd_name;
> - =A0 =A0 =A0 struct voltagedomain =A0 =A0 =A0 =A0 =A0 =A0*voltdm;
> =A0 =A0 =A0 =A0struct omap_hwmod_ocp_if =A0 =A0 =A0 =A0**masters; /* =
connect to *_IA */
> =A0 =A0 =A0 =A0struct omap_hwmod_ocp_if =A0 =A0 =A0 =A0**slaves; =A0/=
* connect to *_TA */
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*dev_attr;
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
