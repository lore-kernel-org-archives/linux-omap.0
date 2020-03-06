Return-Path: <SRS0=FBvQ=4X=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863D1C10F25
	for <linux-omap@archiver.kernel.org>; Fri,  6 Mar 2020 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9ED21D7E
	for <linux-omap@archiver.kernel.org>; Fri,  6 Mar 2020 16:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFQ5m (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:57:42 -0500
Received: from muru.com ([72.249.23.125]:59102 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFQ5m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 6 Mar 2020 11:57:42 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 572E68027;
        Fri,  6 Mar 2020 16:58:27 +0000 (UTC)
Date:   Fri, 6 Mar 2020 08:57:38 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 1/6] clocksource: timer-ti-dm: Convert to SPDX
 identifier
Message-ID: <20200306165738.GC37466@atomide.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200305082715.15861-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305082715.15861-2-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200305 08:29]:
> Use SPDX-License-Identifier instead of a verbose license text.

Acked-by: Tony Lindgren <tony@atomide.com>
