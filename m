Return-Path: <SRS0=KqvK=AN=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D305DC433E0
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B877E20EDD
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGBPlB (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:41:01 -0400
Received: from muru.com ([72.249.23.125]:60280 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGBPlA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 2 Jul 2020 11:41:00 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EE4FF8062;
        Thu,  2 Jul 2020 15:41:51 +0000 (UTC)
Date:   Thu, 2 Jul 2020 08:40:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-omap@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        "Andrew F . Davis" <afd@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] soc: ti: omap-prm: Configure sgx power domain for
 am3 and am4
Message-ID: <20200702154055.GJ37466@atomide.com>
References: <20200622164652.12054-4-tony@atomide.com>
 <202006300345.RrpFuQqi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006300345.RrpFuQqi%lkp@intel.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* kernel test robot <lkp@intel.com> [200629 19:24]:
> >> drivers/soc/ti/omap_prm.c:98:21: warning: attribute declaration must precede definition [-Wignored-attributes]
>    static const struct __maybe_unused omap_prm_domain_map omap_prm_noinact = {

Thanks no more need for __maybe_unused with these patches actually,
so I'll just drop those from the series.

Regards,

Tony
