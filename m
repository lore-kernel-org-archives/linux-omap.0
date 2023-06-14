Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A537EB64D9
	for <linux-omap@archiver.kernel.org>; Wed, 14 Jun 2023 08:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFNIFo (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 14 Jun 2023 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243113AbjFNIFl (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jun 2023 04:05:41 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC67B13E;
        Wed, 14 Jun 2023 01:05:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 29C6C8027;
        Wed, 14 Jun 2023 08:05:35 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:05:33 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: Use of_range_to_resource() for "ranges"
 parsing
Message-ID: <20230614080533.GG14287@atomide.com>
References: <20230609183252.1767487-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609183252.1767487-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [230609 21:33]:
> "ranges" is a standard property with common parsing functions. Users
> shouldn't be implementing their own parsing of it. Use the recently
> added of_range_to_resource() function instead for OMAP hwmod.

Thanks applying into omap-for-v6.5/cleanup.

Tony
