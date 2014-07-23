From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable()
Date: Wed, 23 Jul 2014 01:50:03 -0700
Message-ID: <20140723085003.GB22006@atomide.com>
References: <1405301778.29716.72.camel@mars>
 <20980858CB6D3A4BAE95CA194937D5E73EB02569@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11467 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaGWIva (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2014 04:51:30 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EB02569@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Daniel Mack <zonque@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, "Javier Martinez Canillas (javier@dowhile0.org)" <javier@dowhile0.org>, "Ash Charles (ashcharles@gmail.com)" <ashcharles@gmail.com>

* Gupta, Pekon <pekon@ti.com> [140713 22:43]:
> >From: Christoph Fritz [mailto:chf.fritz@googlemail.com]
> >
> >This patch adds bch8 ecc software fallback which is mostly used by
> >omap3s because they lack hardware elm support.
> >
> >Fixes: 0611c41934ab35ce84dea34ab291897ad3cbc7be (ARM: OMAP2+: gpmc:
> >update gpmc_hwecc_bch_capable() for new platforms and ECC schemes)
> >Cc: <stable@vger.kernel.org> # 3.15.x+
> >Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> >---
> > arch/arm/mach-omap2/gpmc-nand.c |   18 ++++++++++--------
> > 1 file changed, 10 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> >index 17cd393..93914d2 100644
> >--- a/arch/arm/mach-omap2/gpmc-nand.c
> >+++ b/arch/arm/mach-omap2/gpmc-nand.c
> >@@ -50,6 +50,16 @@ static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
> > 		 soc_is_omap54xx() || soc_is_dra7xx())
> > 		return 1;
> >
> >+	if (ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW ||
> >+		 ecc_opt == OMAP_ECC_BCH8_CODE_HW_DETECTION_SW) {
> >+		if (cpu_is_omap24xx())
> >+			return 0;
> >+		else if (cpu_is_omap3630() && (GET_OMAP_REVISION() == 0))
> >+			return 0;
> >+		else
> >+			return 1;
> >+	}
> >+
> > 	/* OMAP3xxx do not have ELM engine, so cannot support ECC schemes
> > 	 * which require H/W based ECC error detection */
> > 	if ((cpu_is_omap34xx() || cpu_is_omap3630()) &&
> >@@ -57,14 +67,6 @@ static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
> > 		 (ecc_opt == OMAP_ECC_BCH8_CODE_HW)))
> > 		return 0;
> >
> >-	/*
> >-	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
> >-	 * and AM33xx derivates. Other chips may be added if confirmed to work.
> >-	 */
> >-	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) &&
> >-	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)))
> >-		return 0;
> >-
> > 	/* legacy platforms support only HAM1 (1-bit Hamming) ECC scheme */
> > 	if (ecc_opt == OMAP_ECC_HAM1_CODE_HW)
> > 		return 1;
> >--
> >1.7.10.4
> >
> Thanks much for this fix.
> Reviewed-by: Pekon Gupta <pekon@ti.com>

Applying into omap-for-v3.16/fixes thanks.

Tony
