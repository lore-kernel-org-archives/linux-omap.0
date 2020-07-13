Return-Path: <SRS0=HJjW=AY=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C14FC433ED
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6905F20773
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgGMQcc (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:32:32 -0400
Received: from muru.com ([72.249.23.125]:36652 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgGMQcc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 13 Jul 2020 12:32:32 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0CC618106;
        Mon, 13 Jul 2020 16:32:28 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:32:28 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 21/25] pinctrl: pinctrl-single: Fix struct/function
 documentation blocks
Message-ID: <20200713163228.GK5849@atomide.com>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-22-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713144930.1034632-22-lee.jones@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [200713 14:50]:
> Add some missing attributes/parameter descriptions, remove other
> superfluous ones, add struct header titles and fix misspellings.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/pinctrl/pinctrl-single.c:50: warning: Function parameter or member 'mask' not described in 'pcs_func_vals'
>  drivers/pinctrl/pinctrl-single.c:97: warning: Function parameter or member 'conf' not described in 'pcs_function'
>  drivers/pinctrl/pinctrl-single.c:97: warning: Function parameter or member 'nconfs' not described in 'pcs_function'
>  drivers/pinctrl/pinctrl-single.c:659: warning: Function parameter or member 'pin_pos' not described in 'pcs_add_pin'
>  drivers/pinctrl/pinctrl-single.c:985: warning: Excess function parameter 'pctldev' description in 'pcs_parse_one_pinctrl_entry'
>  drivers/pinctrl/pinctrl-single.c:1357: warning: Cannot understand  * @reg:        virtual address of interrupt register
>  drivers/pinctrl/pinctrl-single.c:1377: warning: Function parameter or member 'pcs_soc' not described in 'pcs_irq_set'
>  drivers/pinctrl/pinctrl-single.c:1377: warning: Function parameter or member 'irq' not described in 'pcs_irq_set'
>  drivers/pinctrl/pinctrl-single.c:1377: warning: Function parameter or member 'enable' not described in 'pcs_irq_set'
>  drivers/pinctrl/pinctrl-single.c:1458: warning: Function parameter or member 'pcs_soc' not described in 'pcs_irq_handle'
>  drivers/pinctrl/pinctrl-single.c:1458: warning: Excess function parameter 'pcs_irq' description in 'pcs_irq_handle'
>  drivers/pinctrl/pinctrl-single.c:1506: warning: Excess function parameter 'irq' description in 'pcs_irq_chain_handler'

Thanks looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
