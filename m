Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A37DC433E6
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 11:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025FB23104
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 11:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392322AbhAZLWP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 26 Jan 2021 06:22:15 -0500
Received: from muru.com ([72.249.23.125]:53228 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392266AbhAZLU6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 26 Jan 2021 06:20:58 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 76DD48057;
        Tue, 26 Jan 2021 11:20:21 +0000 (UTC)
Date:   Tue, 26 Jan 2021 13:20:14 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, hns@goldelico.com,
        aford@beaconembedded.com,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: omap36xx: Remove turbo mode for 1GHz
 variants
Message-ID: <YA/67lrhQsPRxiEw@atomide.com>
References: <20210109170103.1249838-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109170103.1249838-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [210109 19:01]:
> Previously, the 1GHz variants were marked as a turbo,
> because that variant has reduced thermal operating range.
> 
> Now that the thermal throttling is in place, it should be
> safe to remove the turbo-mode from the 1GHz variants, because
> the CPU will automatically slow if the thermal limit is reached.

Thanks applying into omap-for-v5.12/dt.

Tony
