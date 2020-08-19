Return-Path: <SRS0=EIKI=B5=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E8C433E1
	for <linux-omap@archiver.kernel.org>; Wed, 19 Aug 2020 07:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1421220786
	for <linux-omap@archiver.kernel.org>; Wed, 19 Aug 2020 07:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHSHWo (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:22:44 -0400
Received: from muru.com ([72.249.23.125]:41000 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgHSHWn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 19 Aug 2020 03:22:43 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E80458107;
        Wed, 19 Aug 2020 07:22:43 +0000 (UTC)
Date:   Wed, 19 Aug 2020 10:23:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] arm: mach-omap1: mux.h: delete duplicate word
Message-ID: <20200819072312.GC2994@atomide.com>
References: <20200726002212.19896-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726002212.19896-1-rdunlap@infradead.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Randy Dunlap <rdunlap@infradead.org> [200726 03:22]:
> Drop the repeated word "is".

Thanks applying into omap-for-v5.9/omap1.

Tony
