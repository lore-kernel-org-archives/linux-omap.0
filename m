Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9CC77B75
	for <linux-omap@archiver.kernel.org>; Wed, 17 May 2023 06:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjEQG0Z (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 17 May 2023 02:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjEQG0X (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 17 May 2023 02:26:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DFB749EE;
        Tue, 16 May 2023 23:25:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 219918108;
        Wed, 17 May 2023 06:25:49 +0000 (UTC)
Date:   Wed, 17 May 2023 09:25:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lee@kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com, nm@ti.com,
        afd@ti.com, msp@baylibre.com
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Message-ID: <20230517062547.GN14287@atomide.com>
References: <20230511122100.2225417-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511122100.2225417-1-jneanne@baylibre.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Jerome Neanne <jneanne@baylibre.com> [230511 12:21]:
> Use new API for power-off mode support:
> Link: https://lwn.net/Articles/894511/
> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
> 
> sys-off API allows support of shutdown handler and restart handler.

Reviewed-by: Tony Lindgren <tony@atomide.com>
