Return-Path: <SRS0=sQ2K=AK=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B305FC433E4
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 21:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF9B21531
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 21:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgF2SuL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:50:11 -0400
Received: from muru.com ([72.249.23.125]:59954 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbgF2SuL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:11 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 57AB781BD;
        Mon, 29 Jun 2020 18:15:12 +0000 (UTC)
Date:   Mon, 29 Jun 2020 11:14:17 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap: Align L2 cache-controller nodename with
 dtschema
Message-ID: <20200629181417.GZ37466@atomide.com>
References: <20200626080619.4017-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626080619.4017-1-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzk@kernel.org> [200626 01:07]:
> Fix dtschema validator warnings like:
>     l2-cache-controller@48242000: $nodename:0:
>         'l2-cache-controller@48242000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Applying into omap-for-v5.9/dt thanks.

Tony
