Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A7C47083
	for <linux-omap@archiver.kernel.org>; Fri,  4 Jun 2021 08:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353956141D
	for <linux-omap@archiver.kernel.org>; Fri,  4 Jun 2021 08:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhFDIJY (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 4 Jun 2021 04:09:24 -0400
Received: from muru.com ([72.249.23.125]:36208 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhFDIJY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 4 Jun 2021 04:09:24 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3631E8167;
        Fri,  4 Jun 2021 08:07:45 +0000 (UTC)
Date:   Fri, 4 Jun 2021 11:07:34 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [RESEND PATCH] pinctrl: single: config: enable the pin's input
Message-ID: <YLnfRpV8dvc59lKL@atomide.com>
References: <20210602150420.18202-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602150420.18202-1-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dario Binacchi <dariobin@libero.it> [210602 15:04]:
> It enables / disables the input buffer. As explained in the description
> of 'enum pin_config_param' this does not affect the pin's ability to
> drive output.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
