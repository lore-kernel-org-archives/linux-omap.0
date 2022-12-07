Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C764C63705
	for <linux-omap@archiver.kernel.org>; Wed,  7 Dec 2022 13:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiLGNwC (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 7 Dec 2022 08:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLGNwB (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2022 08:52:01 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21A605B583;
        Wed,  7 Dec 2022 05:51:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 458D5804D;
        Wed,  7 Dec 2022 13:51:58 +0000 (UTC)
Date:   Wed, 7 Dec 2022 15:51:57 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "B. Niedermayr" <benedikt.niedermayr@siemens.com>,
        krzysztof.kozlowski@linaro.org, rogerq@kernel.org
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v9 1/2] memory: omap-gpmc: wait pin additions
Message-ID: <Y5CafQpZnjSSCMoj@atomide.com>
References: <20221102133047.1654449-1-benedikt.niedermayr@siemens.com>
 <20221102133047.1654449-2-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102133047.1654449-2-benedikt.niedermayr@siemens.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* B. Niedermayr <benedikt.niedermayr@siemens.com> [221102 13:21]:
> From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> 
> This patch introduces support for setting the wait-pin polarity as well
> as using the same wait-pin for different CS regions.

Looks like Linux next commit 89aed3cd5cb9 ("memory: omap-gpmc: wait pin
additions") breaks the old smsc911x using devices somehow for nfsroot.

Reverting this commit makes things work again. Any ideas?

Regards,

Tony
