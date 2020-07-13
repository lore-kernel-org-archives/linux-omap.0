Return-Path: <SRS0=HJjW=AY=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16647C433DF
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEBC20773
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 16:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgGMQr4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:47:56 -0400
Received: from muru.com ([72.249.23.125]:36674 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbgGMQr4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 13 Jul 2020 12:47:56 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DCF838106;
        Mon, 13 Jul 2020 16:47:53 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:47:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     Chen Tao <chentao107@huawei.com>, linux-omap@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix possible memory leak in
 omap_hwmod_allocate_module
Message-ID: <20200713164753.GM5849@atomide.com>
References: <20200619104240.55978-1-chentao107@huawei.com>
 <alpine.DEB.2.21.999.2006191518380.26224@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.2006191518380.26224@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [200619 15:20]:
> On Fri, 19 Jun 2020, Chen Tao wrote:
> 
> > Fix memory leak in omap_hwmod_allocate_module not freeing in
> > handling error path.
> > 
> > Fixes: 8c87970543b17("ARM: OMAP2+: Add functions to allocate module data from device tree")
> > Signed-off-by: Chen Tao <chentao107@huawei.com>
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>

Thanks applying into fixes.

Tony
