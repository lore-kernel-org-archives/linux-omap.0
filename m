Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37027C4338F
	for <linux-omap@archiver.kernel.org>; Tue, 27 Jul 2021 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166806120F
	for <linux-omap@archiver.kernel.org>; Tue, 27 Jul 2021 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhG0Il5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:41:57 -0400
Received: from muru.com ([72.249.23.125]:55634 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235629AbhG0Il5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 27 Jul 2021 04:41:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9BACB80F0;
        Tue, 27 Jul 2021 08:42:14 +0000 (UTC)
Date:   Tue, 27 Jul 2021 11:41:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     David Lechner <david@lechnology.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: am335x-boneblue: add gpio-line-names
Message-ID: <YP/G09uOO6DxUfVG@atomide.com>
References: <20210709214706.1583984-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709214706.1583984-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* David Lechner <david@lechnology.com> [210710 00:49]:
> This adds gpio-line-names to the BeagleBone Blue DTS. The line names
> are based on the BeagleBone Blue rev A2 schematic.

Thanks applying into omap-for-v5.14/dt. I had to merge with the change
for ls-buf-en-hog so please check after I push out the branch a bit later
on.

Regards,

Tony
