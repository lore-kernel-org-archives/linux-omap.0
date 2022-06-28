Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEEC433EF
	for <linux-omap@archiver.kernel.org>; Tue, 28 Jun 2022 05:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbiF1Fvc (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiF1Fvb (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2022 01:51:31 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7A59266;
        Mon, 27 Jun 2022 22:51:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 548AB8106;
        Tue, 28 Jun 2022 05:46:18 +0000 (UTC)
Date:   Tue, 28 Jun 2022 08:51:29 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH] ARM: omap2: Kconfig: Fix indentation
Message-ID: <YrqW4XMjM5I7EOac@atomide.com>
References: <20220523063040.10991-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523063040.10991-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Juerg Haefliger <juerg.haefliger@canonical.com> [220523 10:23]:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While at it, remove an extra empty line.

Thanks applying into omap-for-v5.20/soc. I updated the patch for
empty line being now an extra tab.

Tony
