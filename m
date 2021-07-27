Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2691C4338F
	for <linux-omap@archiver.kernel.org>; Tue, 27 Jul 2021 08:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B924C61151
	for <linux-omap@archiver.kernel.org>; Tue, 27 Jul 2021 08:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhG0Imw (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:42:52 -0400
Received: from muru.com ([72.249.23.125]:55646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235629AbhG0Imw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 27 Jul 2021 04:42:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EBD1380F0;
        Tue, 27 Jul 2021 08:43:09 +0000 (UTC)
Date:   Tue, 27 Jul 2021 11:42:50 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH] ARM: dts: Add support for dra762 abz package
Message-ID: <YP/HCiWEK2fH0/Na@atomide.com>
References: <20210715212024.35738-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715212024.35738-1-khilman@baylibre.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@baylibre.com> [210716 00:20]:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> dra762 abz package is pin compatible with dra742 and few peripherals
> like DDR with upgraded speed. Add dt support for this SoC.

Thanks applying into omap-for-v5.15/dt.

Tony
