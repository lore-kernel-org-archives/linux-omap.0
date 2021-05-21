Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6824C433B4
	for <linux-omap@archiver.kernel.org>; Fri, 21 May 2021 09:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B191D613CA
	for <linux-omap@archiver.kernel.org>; Fri, 21 May 2021 09:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhEUJ1O (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 21 May 2021 05:27:14 -0400
Received: from muru.com ([72.249.23.125]:58366 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhEUJ1F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 21 May 2021 05:27:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8350380C0;
        Fri, 21 May 2021 09:25:43 +0000 (UTC)
Date:   Fri, 21 May 2021 12:25:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pinctrl: single: set pinmux from pins debug file
Message-ID: <YKd8jx3wfa7ZsRxK@atomide.com>
References: <20210517200002.6316-1-dariobin@libero.it>
 <20210517200002.6316-3-dariobin@libero.it>
 <YKNZIzyO5Q/XGLRs@atomide.com>
 <1340368809.152927.1621328251188@mail1.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1340368809.152927.1621328251188@mail1.libero.it>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dario Binacchi <dariobin@libero.it> [210518 08:57]:
> I thought about passing char *buf because it seemed more generic 
> to me. As the output of pin_dbg_show() depends on the platform 
> driver, perhaps pin_dbg_set() may need driver-dependent data.
> Is it possible that only the value to be set in the register 
> (unsigned int) is required?

Maybe Linus W can answer this one.

Regards,

Tony
