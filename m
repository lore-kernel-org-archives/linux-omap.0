Return-Path: <SRS0=mo/n=EE=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE492C55178
	for <linux-omap@archiver.kernel.org>; Thu, 29 Oct 2020 10:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848F820731
	for <linux-omap@archiver.kernel.org>; Thu, 29 Oct 2020 10:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgJ2Kva (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 29 Oct 2020 06:51:30 -0400
Received: from muru.com ([72.249.23.125]:47132 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgJ2Kva (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:30 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2074C807E;
        Thu, 29 Oct 2020 10:51:33 +0000 (UTC)
Date:   Thu, 29 Oct 2020 12:51:25 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     edubezval@gmail.com, j-keerthy@ti.com, aford173@gmail.com,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, daniel.lezcano@linaro.org
Subject: Re: [PATCH] thermal: ti-soc-thermal: Disable the CPU PM notifier for
 OMAP4430
Message-ID: <20201029105125.GJ5639@atomide.com>
References: <20201029100335.27665-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100335.27665-1-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [201029 10:03]:
> Disabling the notifier fixes the random shutdowns on OMAP4430 (ES2.0 and ES2.1)
> but it does not cause any issues on OMAP4460 (PandaES) or OMAP3630 (BeagleXM).
> Tony's duovero with OMAP4430 ES2.3 did not ninja-shutdown, but he also have
> constant and steady stream of:
> thermal thermal_zone0: failed to read out thermal zone (-5)

Works for me and I've verified duovero still keeps hitting core ret idle:

Tested-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
