From: =?EUC-KR?B?tOvAzrHi?= <daeinki@gmail.com>
Subject: Hi David Brownell. I have a question for twl4030 driver.
Date: Fri, 13 Feb 2009 12:06:18 +0900
Message-ID: <90b950fc0902121906kdf51637v21b90a2aba94a93f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:38505 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZBMDGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 22:06:19 -0500
Received: by yx-out-2324.google.com with SMTP id 8so554828yxm.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 19:06:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

I added "struct regulator_init_data xxx_vpll2" to board-xx.c file to use VPLL2.
but couldn't use it because you annotated codes for VPLL2 like below.

in drivers/mfd/twl4030-core.c file.
	/* maybe add LDOs that are omitted on cost-reduced parts */
	if (twl_has_regulator() && !(features & TPS_SUBSET)) {
		/*
		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2);
		if (IS_ERR(child))
			return PTR_ERR(child);
		*/

also in drivers/regulator/twl4030-regulator.c file.
static struct twlreg_info twl4030_regs[] = {
	/*
 	TWL_ADJUSTABLE_LDO(VPLL1, 0x2f, 7),
 	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, 8),
	*/

So I could use VPLL2 after I get rid of those annotations.
I wonder why did you annotate for VPLL2.
Does using VPLL2 has some problems?

- InKi -
