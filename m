Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CA3C4707F
	for <linux-omap@archiver.kernel.org>; Thu, 27 May 2021 12:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B63761378
	for <linux-omap@archiver.kernel.org>; Thu, 27 May 2021 12:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhE0MPN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 May 2021 08:15:13 -0400
Received: from muru.com ([72.249.23.125]:32852 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235050AbhE0MPB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 27 May 2021 08:15:01 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C958D80A8;
        Thu, 27 May 2021 12:13:33 +0000 (UTC)
Date:   Thu, 27 May 2021 15:13:24 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Cleanup OMAP Mailbox nodes for YAML binding
Message-ID: <YK+M5FhAU7pxANSW@atomide.com>
References: <20210518173645.12270-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518173645.12270-1-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [210518 20:37]:
> Hi Tony,
> 
> The following series is minor cleanups in the OMAP Mailbox nodes
> on various OMAP2+ SoCs. The changes are to bring the nodes in
> compliance with the OMAP Mailbox YAML binding conversion [1]. The
> changes can be applied independent of the YAML conversion, and
> all the dtbs_check warnings around Mailbox nodes should be gone
> once all the dts patches and binding conversion are merged.

Applying into omap-for-v5.14/dt thanks,

Tony
