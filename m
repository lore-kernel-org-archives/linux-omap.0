Return-Path: <SRS0=8dcx=7O=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B95C433E0
	for <linux-omap@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7A1206C3
	for <linux-omap@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFAQSz (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:18:55 -0400
Received: from muru.com ([72.249.23.125]:56616 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQSz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 1 Jun 2020 12:18:55 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 36C6F804F;
        Mon,  1 Jun 2020 16:19:45 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:18:51 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Subject: Re: [PATCH] pinctrl-single: fix pcs_parse_pinconf() return val
Message-ID: <20200601161851.GC37466@atomide.com>
References: <20200531204147.GA664833@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531204147.GA664833@x1>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Drew Fustini <drew@beagleboard.org> [200531 20:42]:
> This patch causes pcs_parse_pinconf() to return an error when no
> pinctrl_map is added.  The current behavior is to return 0 when
> !PCS_HAS_PINCONF or !nconfs.  Thus pcs_parse_one_pinctrl_entry()
> incorrectly assumes that a map was added and sets num_maps = 2.

Looks OK to me, would be good to wait for Haojian to test this one.

Regards,

Tony
