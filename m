Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803AC433DB
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 11:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC3661A06
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 11:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCXLov (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:44:51 -0400
Received: from muru.com ([72.249.23.125]:46460 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhCXLop (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 24 Mar 2021 07:44:45 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DC6A48117;
        Wed, 24 Mar 2021 11:45:41 +0000 (UTC)
Date:   Wed, 24 Mar 2021 13:44:41 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] bus: ti-sysc: Use kzalloc for allocating only one
 thing
Message-ID: <YFsmKYv2u2zFzpPe@atomide.com>
References: <20201229135147.23593-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229135147.23593-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Zheng Yongjun <zhengyongjun3@huawei.com> [201229 15:51]:
> Use kzalloc rather than kcalloc(1,...)

Thanks applying into omap-for-v5.13/ti-sysc.

Tony
