Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125FEC76195
	for <linux-omap@archiver.kernel.org>; Mon, 27 Mar 2023 07:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjC0H1y (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC0H1y (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Mar 2023 03:27:54 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C613E3;
        Mon, 27 Mar 2023 00:27:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C8E008108;
        Mon, 27 Mar 2023 07:27:52 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:27:51 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: ti-sysc: Remove open coded "ranges" parsing
Message-ID: <20230327072751.GS7501@atomide.com>
References: <20230201220002.246907-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201220002.246907-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [230202 00:00]:
> "ranges" is a standard property and we have common helper functions for
> parsing it, so let's use them.

Nice, applying into omap-for-v6.4/ti-sysc.

Thanks,

Tony
