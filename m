From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH 4/5] [RFC] ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable
Date: Tue, 8 Jul 2014 06:25:13 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAFC085@DBDE04.ent.ti.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-5-git-send-email-chf.fritz@googlemail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAEA346@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39100 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbaGHGZu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 02:25:50 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAEA346@DBDE04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>, Tony Lindgren <tony@atomide.com>
Cc: Daniel Mack <zonque@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, "Javier Martinez Canillas (javier@dowhile0.org)" <javier@dowhile0.org>, "Ash Charles (ashcharles@gmail.com)" <ashcharles@gmail.com>

Hi Cristoph,

>From: Pekon Gupta <Pekon@ti.com>
>>From: Christoph Fritz [mailto:chf.fritz@googlemail.com]
>>
>>Most dt omap3 boards configure nand-ecc-opt as bch8. Due
>>to lack of hardware elm support, bch8 software implementation
>>gets set.
>>
>>Since commit 0611c41934ab35ce84dea "ARM: OMAP2+: gpmc: update
>>gpmc_hwecc_bch_capable() for new platforms and ECC schemes",
>>nand support stops working.
>>
>>This patch allows ecc software fallback.
>
>Pleas add following tag at top of commit message.
>
>Fixes: commit 0611c41934ab35ce84dea34ab291897ad3cbc7be
>ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms and ECC schemes
>
>And please mark it for 3.15 stable if this gets accepted after 3.15-rcx.
>Cc: <stable@vger.kernel.org> # 3.15.x+
>
>
>>---
>> arch/arm/mach-omap2/gpmc-nand.c |   16 ++++++----------
>> 1 file changed, 6 insertions(+), 10 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>>index 4349e82..52c4834 100644
>>--- a/arch/arm/mach-omap2/gpmc-nand.c
>>+++ b/arch/arm/mach-omap2/gpmc-nand.c
>>@@ -43,13 +43,17 @@ static struct platform_device gpmc_nand_device = {
>> 	.resource	= gpmc_nand_resource,
>> };
>>
>>-static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>>+static bool gpmc_ecc_bch_capable(enum omap_ecc ecc_opt)
>
>I don't think this renaming is really required with this fix, so please
>drop it and just keep it simple only for OMAP3 fix.
>
>
>> {
>> 	/* platforms which support all ECC schemes */
>> 	if (soc_is_am33xx() || cpu_is_omap44xx() ||
>> 		 soc_is_omap54xx() || soc_is_dra7xx())
>> 		return 1;
>>
>>+	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) ||
>>+		(ecc_opt == OMAP_ECC_BCH8_CODE_HW_DETECTION_SW))
>>+		return 1;
>>+
>
>Note: Some very old legacy platforms have initial version of GPMC engine
>which only supports Hamming ECC, and not BCH ECC scheme, so lets
>filter them out to maintain backward compatibility.
>
>(1) As per TRM, OMAP2 platform does not support BCH ECC schemes,
>      So please filter out OMAP2 devices from this check ...
>
>(2) I don't know the history but below comment says:
>"* For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1"
>
>if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) ||
>	 (ecc_opt == OMAP_ECC_BCH8_CODE_HW_DETECTION_SW))  {
>	if (cpu_is_omap24xx())
>		return 0;
>	else if (cpu_is_omap3630() && (GET_OMAP_REVISION() == 0))
>		return 0;
>	else
>		return 1;
>}
>
>
>> 	/* OMAP3xxx do not have ELM engine, so cannot support ECC schemes
>> 	 * which require H/W based ECC error detection */
>> 	if ((cpu_is_omap34xx() || cpu_is_omap3630()) &&
>>@@ -57,14 +61,6 @@ static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>> 		 (ecc_opt == OMAP_ECC_BCH8_CODE_HW)))
>> 		return 0;
>>
>>-	/*
>>-	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
>>-	 * and AM33xx derivates. Other chips may be added if confirmed to work.
>>-	 */
>>-	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) &&
>>-	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)))
>>-		return 0;
>>-
>Thanks for removing this, I too wasn't confident of this either.
>
>
>> 	/* legacy platforms support only HAM1 (1-bit Hamming) ECC scheme */
>> 	if (ecc_opt == OMAP_ECC_HAM1_CODE_HW)
>> 		return 1;
>>@@ -140,7 +136,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>>
>> 	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
>>
>>-	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt)) {
>>+	if (!gpmc_ecc_bch_capable(gpmc_nand_data->ecc_opt)) {
>
>Please drop this renaming from this patch.
>
>> 		dev_err(dev, "Unsupported NAND ECC scheme selected\n");
>> 		return -EINVAL;
>> 	}
>>--
>>1.7.10.4
>
>You may send this patch separately apart from the series, so that
>this gets accepted in current 3.15-rcx.
>
>with regards, Pekon

Do you plan to re-spin this patch with above comments, and mark it for stable?
It would be helpful for all OMAP3 users.


with regards, pekon
