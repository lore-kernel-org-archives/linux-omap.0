Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BBC433DB
	for <linux-omap@archiver.kernel.org>; Wed, 17 Mar 2021 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4190E64F67
	for <linux-omap@archiver.kernel.org>; Wed, 17 Mar 2021 14:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhCQO30 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:29:26 -0400
Received: from muru.com ([72.249.23.125]:44138 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhCQO3Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 17 Mar 2021 10:29:24 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 54A0B80BA;
        Wed, 17 Mar 2021 14:30:13 +0000 (UTC)
Date:   Wed, 17 Mar 2021 16:29:19 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-omap@vger.kernel.org
Subject: Re: [PATCHv2 01/38] ARM: dts: motorola-cpcap-mapphone: Prepare for
 dtbs_check parsing
Message-ID: <YFISPyIMCbp6WcAr@atomide.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317134904.80737-2-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [210317 13:50]:
> '<&gpio1 parameters &gpio2 parameters>' and '<&gpio1 parameters>,
> <&gpio2 parameters>' result in the same DTB, but second format has
> better source code readability. Also 'dtbs_check' currently uses
> this format to determine the amount of items specified, so using
> this syntax is needed to successfully verify the devicetree source
> against a DT schema format.

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
