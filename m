Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B8C433E0
	for <linux-omap@archiver.kernel.org>; Thu,  4 Feb 2021 06:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3AF564F58
	for <linux-omap@archiver.kernel.org>; Thu,  4 Feb 2021 06:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhBDGq1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 4 Feb 2021 01:46:27 -0500
Received: from muru.com ([72.249.23.125]:56938 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhBDGq1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 4 Feb 2021 01:46:27 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 99D6280B3;
        Thu,  4 Feb 2021 06:45:57 +0000 (UTC)
Date:   Thu, 4 Feb 2021 08:45:42 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am33xx: add aliases for mmc interfaces
Message-ID: <YBuYFkNFxH8Ngtny@atomide.com>
References: <20210128155644.6553-1-mans@mansr.com>
 <YBPGyuNQhSypIf1y@atomide.com>
 <yw1xczxoas3l.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xczxoas3l.fsf@mansr.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Måns Rullgård <mans@mansr.com> [210129 11:40]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Mans Rullgard <mans@mansr.com> [210128 18:09]:
> >> Without DT aliases, the numbering of mmc interfaces is unpredictable.
> >> Adding them makes it possible to refer to devices consistently.  The
> >> popular suggestion to use UUIDs obviously doesn't work with a blank
> >> device fresh from the factory.
> >> 
> >> See fa2d0aa96941 "mmc: core: Allow setting slot index via device tree
> >> alias" for more discussion.
> >
> > Sounds good to me, but will wait a few days before applying to make sure
> > this is still what we have agreed on :)
> 
> If it helps the decision, my existing systems fail to boot without
> something like this due to the eMMC moving from /dev/mmcblk1 to mmcblk0,
> at least sometimes.  I guess the kernel cares deeply about not breaking
> userspace, except when it doesn't give a damn.
> 
> I've been fighting this problem in various forms for the last 10 years
> or so, and I was hoping it would finally be over.

Yes this issue has been bugging folks for long time. Applying into fixes
thanks.

Tony
