From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
Date: Wed, 29 Aug 2012 17:15:02 -0700
Message-ID: <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53181 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752272Ab2H3APY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 20:15:24 -0400
Received: by ialo24 with SMTP id o24so2242202ial.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 17:15:23 -0700 (PDT)
In-Reply-To: <1346230576-20004-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Aug 29, 2012 at 1:56 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index d7f55e4..a3831a2 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3156,6 +3156,7 @@ static struct omap_clk omap44xx_clks[] = {
>         CLK(NULL,       "dss_tv_clk",                   &dss_tv_clk,    CK_443X),
>         CLK(NULL,       "dss_48mhz_clk",                &dss_48mhz_clk, CK_443X),
>         CLK(NULL,       "dss_dss_clk",                  &dss_dss_clk,   CK_443X),
> +       CLK(NULL,       "dss_fck",                      &dss_fck,       CK_443X),
>         CLK("omapdss_dss",      "ick",                          &dss_fck,       CK_443X),

Is it right to re-use dss_fck for the "ick" here?  I think it is due
to omap4 modulemode stuff but I don't have DM in front of me and
wanted a double-check...

Regards,
Mike
