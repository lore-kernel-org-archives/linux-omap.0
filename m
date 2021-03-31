Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4CCC433DB
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 06:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1833619B1
	for <linux-omap@archiver.kernel.org>; Wed, 31 Mar 2021 06:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhCaGJG (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 Mar 2021 02:09:06 -0400
Received: from muru.com ([72.249.23.125]:49114 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233747AbhCaGIb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 31 Mar 2021 02:08:31 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A094780F1;
        Wed, 31 Mar 2021 06:08:59 +0000 (UTC)
Date:   Wed, 31 Mar 2021 09:07:53 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, linux@armlinux.org.uk,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: OMAP2+: fix incorrect kernel-doc comment syntax in
 file
Message-ID: <YGQRuch0+sw2o3wy@atomide.com>
References: <20210330205908.26800-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330205908.26800-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Aditya Srivastava <yashsri421@gmail.com> [210331 00:00]:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for arch/arm/mach-omap2/omap_twl.c follows this syntax, but the
> content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> "warning: wrong kernel-doc identifier on line:
>  * OMAP and TWL PMIC specific initializations."
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.

Thanks applying into omap-for-v5.13/soc.

Tony
