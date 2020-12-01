Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A9C83016
	for <linux-omap@archiver.kernel.org>; Tue,  1 Dec 2020 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124292224A
	for <linux-omap@archiver.kernel.org>; Tue,  1 Dec 2020 07:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgLAH0T (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:26:19 -0500
Received: from muru.com ([72.249.23.125]:49590 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgLAH0R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 1 Dec 2020 02:26:17 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4BAC880A9;
        Tue,  1 Dec 2020 07:25:44 +0000 (UTC)
Date:   Tue, 1 Dec 2020 09:25:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: am335x-evm/evmsk/icev2: switch to new cpsw
 switch drv
Message-ID: <20201201072533.GS26857@atomide.com>
References: <20201119154452.26961-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119154452.26961-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [201119 17:45]:
> Hi Tony,
> 
> This is the initial conversation of am335x boards to use new cpsw switch driver.
> This series adds the cpsw switch driver DT definition and am335x-evm/evmsk/icev2
> boards are converted to use it.

Thanks applying into omap-for-v5.11/dt.

Regards,

Tony
