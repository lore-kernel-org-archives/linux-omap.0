Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0495C77B73
	for <linux-omap@archiver.kernel.org>; Wed, 31 May 2023 04:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjEaERF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 31 May 2023 00:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjEaERE (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 31 May 2023 00:17:04 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D603CBE;
        Tue, 30 May 2023 21:17:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2F9728164;
        Wed, 31 May 2023 04:17:03 +0000 (UTC)
Date:   Wed, 31 May 2023 07:17:01 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ladislav Michl <oss-lists@triops.cz>
Cc:     linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-twl: add NVRAM support
Message-ID: <20230531041701.GH14287@atomide.com>
References: <ZDf7qZTiml0ijD2g@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDf7qZTiml0ijD2g@lenoch>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Ladislav Michl <oss-lists@triops.cz> [230413 12:56]:
> From: Ladislav Michl <ladis@linux-mips.org>
> Date: Sat, 28 May 2022 19:36:13 +0200
> 
> Export SRAM using nvmem.

Reviewed-by: Tony Lindgren <tony@atomide.com>
