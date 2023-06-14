Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D613EB64DC
	for <linux-omap@archiver.kernel.org>; Wed, 14 Jun 2023 08:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbjFNIIs (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 14 Jun 2023 04:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbjFNIIf (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jun 2023 04:08:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 530701FCC;
        Wed, 14 Jun 2023 01:08:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B59988027;
        Wed, 14 Jun 2023 08:07:41 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:07:40 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ARM: OMAP2+: Fix -Warray-bounds warning in
 _pwrdm_state_switch()
Message-ID: <20230614080740.GH14287@atomide.com>
References: <ZIFVGwImU3kpaGeH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFVGwImU3kpaGeH@work>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Gustavo A. R. Silva <gustavoars@kernel.org> [230608 07:11]:
> If function pwrdm_read_prev_pwrst() returns -EINVAL, we will end
> up accessing array pwrdm->state_counter through negative index
> -22. This is wrong and the compiler is legitimately warning us
> about this potential problem.
> 
> Fix this by sanity checking the value stored in variable _prev_
> before accessing array pwrdm->state_counter.
> 
> Address the following -Warray-bounds warning:
> arch/arm/mach-omap2/powerdomain.c:178:45: warning: array subscript -22 is below array bounds of 'unsigned int[4]' [-Warray-bounds]

Thanks applying into omap-for-v6.5/cleanup, seems this can wait
for the merge window.

Regards,

Tony
