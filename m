From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 2/3] nand: omap2: Remove horrible ifdefs to fix module
 probe
Date: Sat, 6 Sep 2014 18:47:11 -0300
Message-ID: <20140906214711.GB20943@arch.cereza>
References: <1410033389-32357-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1410033389-32357-3-git-send-email-ezequiel@vanguardiasur.com.ar>
 <540B785C.3070400@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:44346 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaIFVsY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Sep 2014 17:48:24 -0400
Received: by mail-qa0-f54.google.com with SMTP id x12so12186541qac.41
        for <linux-omap@vger.kernel.org>; Sat, 06 Sep 2014 14:48:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540B785C.3070400@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>
Cc: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, linux-omap <linux-omap@vger.kernel.org>

On 07 Sep 02:40 AM, pekon wrote:
> + linux-omap, as this patch touches arch/arm/mach-omap2/gpmc.c
> 
> Hi Ezequiel,
> 
> On Sunday 07 September 2014 01:26 AM, Ezequiel Garcia wrote:
> >The current code abuses ifdefs to determine if the selected ECC scheme
> >is supported by the running kernel. As a result the code is hard to read,
> >and it also fails to load as a module.
> >
> >This commit removes all the ifdefs and instead introduces a function
> >omap2_nand_ecc_check() to check if the ECC is supported by using
> >IS_ENABLED(CONFIG_xxx).
> >
> Yup, true.
> Thanks for cleaning up OMAP2 NAND driver, but few feedbacks.
> 

First of all, this is no cleaning. The driver fails to load as a module
over here. Unless I'm missed something, ifdef seemed false when CONFIG_xxx=m.

> Just for record, current version of omap2.c NAND driver has so
> many #ifdef because:
> 
[..]

I can't think of any valid excuses for cluttering the code with ifdefs like
this. There are several ways of doing things cleaner, by grouping code
differently.

[..]
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
[snip]
> If I'm not wrong, this is all you need in this patch
> empty functions for CONFIG_MTD_NAND_ECC_BCH exposed symbols are already
> handled in /include/linux/mtd/nand_bch.h
> 
> So, after this change, you can most of #ifdefs and IS_ENABLED()
> and this patch should be simplified.
> 

OK, I'll take a look. Thanks for the suggestion,
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
