Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F30CC4167B
	for <linux-omap@archiver.kernel.org>; Mon, 12 Dec 2022 07:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiLLHQV (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 12 Dec 2022 02:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLLHQU (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2022 02:16:20 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 930547665;
        Sun, 11 Dec 2022 23:16:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DA80B80B3;
        Mon, 12 Dec 2022 07:16:18 +0000 (UTC)
Date:   Mon, 12 Dec 2022 09:16:17 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "B. Niedermayr" <benedikt.niedermayr@siemens.com>
Cc:     linux-next@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT" 
        <linux-omap@vger.kernel.org>,
        "open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory: omap-gpmc: fix wait pin validation
Message-ID: <Y5bVQSfFV+luA6T0@atomide.com>
References: <20221209123147.591982-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209123147.591982-1-benedikt.niedermayr@siemens.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* B. Niedermayr <benedikt.niedermayr@siemens.com> [221209 12:32]:
> From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> 
> This bug has been introduced after switching from -1 to UINT_MAX
> for GPMC_WAITPIN_INVALID.
> 
> The bug leads to an error when the optional gpmc,wait-pin
> dt-property is not used:
> 
> ...
> gpmc_cs_program_settings: invalid wait-pin (-1)
> ...

This fixes the issue thanks:

Tested-by: Tony Lindgren <tony@atomide.com>
