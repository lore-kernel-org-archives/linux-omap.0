Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A6C433C1
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 12:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285AC619FE
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 12:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhCXMIa (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:08:30 -0400
Received: from muru.com ([72.249.23.125]:46532 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232160AbhCXMIF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 24 Mar 2021 08:08:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 843318117;
        Wed, 24 Mar 2021 12:09:01 +0000 (UTC)
Date:   Wed, 24 Mar 2021 14:08:01 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [RESEND PATCH] ARM: dts: am33xx-l4: fix tscadc@0 node indentation
Message-ID: <YFsroQ0lDR41CRN3@atomide.com>
References: <20210314151629.23921-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314151629.23921-1-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dario Binacchi <dariobin@libero.it> [210314 17:17]:
> Fix the broken indentation of tscadc@0 node.

Applying into omap-for-v5.13/dt thanks.

Tony
