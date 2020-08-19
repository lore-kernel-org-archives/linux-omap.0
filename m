Return-Path: <SRS0=EIKI=B5=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE058C433DF
	for <linux-omap@archiver.kernel.org>; Wed, 19 Aug 2020 07:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3F620738
	for <linux-omap@archiver.kernel.org>; Wed, 19 Aug 2020 07:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHSHTy (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:19:54 -0400
Received: from muru.com ([72.249.23.125]:40932 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgHSHTx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 19 Aug 2020 03:19:53 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B22DB807A;
        Wed, 19 Aug 2020 07:19:52 +0000 (UTC)
Date:   Wed, 19 Aug 2020 10:20:20 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     rnayak@codeaurora.org, paul@pwsan.com, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for v5.9] ARM: OMAP2+: PRM: Replace HTTP links with HTTPS
 ones
Message-ID: <20200819072020.GX2994@atomide.com>
References: <20200719084844.57001-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719084844.57001-1-grandmaster@al2klimov.de>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Alexander A. Klimov <grandmaster@al2klimov.de> [200719 11:48]:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

Thanks applying into omap-for-v5.10/soc.

Tony
