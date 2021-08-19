Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE04C4338F
	for <linux-omap@archiver.kernel.org>; Thu, 19 Aug 2021 06:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9FD610E5
	for <linux-omap@archiver.kernel.org>; Thu, 19 Aug 2021 06:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhHSGkn (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Aug 2021 02:40:43 -0400
Received: from muru.com ([72.249.23.125]:48844 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhHSGkm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 19 Aug 2021 02:40:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7252680EB;
        Thu, 19 Aug 2021 06:40:28 +0000 (UTC)
Date:   Thu, 19 Aug 2021 09:40:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] bus: ti-sysc: Add break in switch statement in
 sysc_init_soc()
Message-ID: <YR38xShxaaEzNPxi@atomide.com>
References: <20210815191852.52271-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815191852.52271-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Nathan Chancellor <nathan@kernel.org> [210815 22:19]:
> After commit a6d90e9f2232 ("bus: ti-sysc: AM3: RNG is GP only"), clang
> with -Wimplicit-fallthrough enabled warns:
> 
> drivers/bus/ti-sysc.c:2958:3: warning: unannotated fall-through between
> switch labels [-Wimplicit-fallthrough]
>                 default:

Thanks applying into fixes.

Regards,

Tony
