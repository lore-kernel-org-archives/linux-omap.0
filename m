From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 2/3] nand: omap2: Remove horrible ifdefs to fix module
 probe
Date: Sat, 6 Sep 2014 20:17:28 -0300
Message-ID: <20140906231728.GA4663@arch.cereza>
References: <1410033389-32357-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1410033389-32357-3-git-send-email-ezequiel@vanguardiasur.com.ar>
 <540B785C.3070400@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:61564 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaIFXSl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Sep 2014 19:18:41 -0400
Received: by mail-qa0-f47.google.com with SMTP id x12so12687711qac.34
        for <linux-omap@vger.kernel.org>; Sat, 06 Sep 2014 16:18:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540B785C.3070400@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>
Cc: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, linux-omap <linux-omap@vger.kernel.org>

On 07 Sep 02:40 AM, pekon wrote:
[..]
> >+static bool omap2_nand_ecc_check(struct omap_nand_info *info,
> >+				 struct omap_nand_platform_data	*pdata)
> >+{
> >+	bool ecc_needs_bch, ecc_needs_omap_bch, ecc_needs_elm;
> >+
> >+	switch (info->ecc_opt) {
> >+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> >+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> >+		ecc_needs_omap_bch = false;
> >+		ecc_needs_bch = true;
> >+		ecc_needs_elm = false;
> >+		break;
> >+	case OMAP_ECC_BCH4_CODE_HW:
> >+	case OMAP_ECC_BCH8_CODE_HW:
> >+	case OMAP_ECC_BCH16_CODE_HW:
> >+		ecc_needs_omap_bch = true;
> >+		ecc_needs_bch = false;
> >+		ecc_needs_elm = true;
> >+		break;
> >+	default:
> >+		ecc_needs_omap_bch = false;
> >+		ecc_needs_bch = false;
> >+		ecc_needs_elm = false;
> >+		break;
> >+	}
> >+
> >+	if (ecc_needs_bch && !IS_ENABLED(CONFIG_MTD_NAND_ECC_BCH)) {
> >+		dev_err(&info->pdev->dev,
> >+			"CONFIG_MTD_NAND_ECC_BCH not enabled\n");
> >+		return false;
> >+	}
> >+	if (ecc_needs_omap_bch && !IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)) {
> >+		dev_err(&info->pdev->dev,
> >+			"CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
> >+		return false;
> >+	}
> >+	if (ecc_needs_elm && !is_elm_present(info, pdata->elm_of_node)) {
> >+		dev_err(&info->pdev->dev, "ELM not available\n");
> >+		return false;
> >+	}
> >+
> >+	return true;
> >  }
> 
> Actually this new function is not required.
> We already have this check in GPMC driver when we select the ecc-scheme.
> Plz refer: File: /arch/arm/mach-omap2/gpmc.c
> 	@@ static int gpmc_probe_nand_child(...)
> 	...
> 	/* select ecc-scheme for NAND */
> 
> is_elm_enabled() is a misnomer here. It actually does not check
> for ELM DTS node, because that check is already done in GPMC driver.
> It rather checks if ELM device is correctly binded and driver
> "initialized" before NAND driver is probed.
> 
> Though ELM is not required during NAND probe because there is no error
> checking/correction required during NAND probe, but this again comes
> from the history of maintaining back-ward compatibility with board-file
> (non DTS) approach. Once we move to all DTS approach may be this can be
> removed (but on case-by case basis).
> 
> [...]
> 
> >diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
> >index 780d1e9..25d1bca 100644
> >--- a/include/linux/platform_data/elm.h
> >+++ b/include/linux/platform_data/elm.h
> >@@ -42,8 +42,22 @@ struct elm_errorvec {
> >  	int error_loc[16];
> >  };
> >
> >+#if IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)
> >  void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
> >  		struct elm_errorvec *err_vec);
> >  int elm_config(struct device *dev, enum bch_ecc bch_type,
> >  	int ecc_steps, int ecc_step_size, int ecc_syndrome_size);
> >+#else
> >+void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
> >+		struct elm_errorvec *err_vec)
> >+{
> >+}
> >+
> >+int elm_config(struct device *dev, enum bch_ecc bch_type,
> >+	int ecc_steps, int ecc_step_size, int ecc_syndrome_size)
> >+{
> >+	return -ENOSYS;
> >+}
> >+#endif /* CONFIG_MTD_NAND_ECC_BCH */
> >+
> >  #endif /* __ELM_H */
> >
> If I'm not wrong, this is all you need in this patch
> empty functions for CONFIG_MTD_NAND_ECC_BCH exposed symbols are already
> handled in /include/linux/mtd/nand_bch.h
> 
> So, after this change, you can most of #ifdefs and IS_ENABLED()
> and this patch should be simplified.
> 

If I understand your proposal correctly you are suggesting to drop the
checks for CONFIG_MTD_NAND_ECC_BCH, CONFIG_MTD_NAND_OMAP_BCH, and the ELM
devicetree node.

However, I'd say that change is even more invasive than this one. This commit
merely replaces the current #ifdefs check with IS_ENABLED and tries to do so
in a cleaner way.

This is done on purpose, to keep the current behavior as much as possible.

In addition, if we don't check for the configs explicitly at probe time,
we would only defer the error until some later point, for instance in the call to
nand_chip->ecc.correct(). I don't think that's user-friendly.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
