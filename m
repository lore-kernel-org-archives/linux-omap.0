Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A2C76195
	for <linux-omap@archiver.kernel.org>; Tue, 28 Mar 2023 05:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1Foo (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 28 Mar 2023 01:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1Fon (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 28 Mar 2023 01:44:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA5A893;
        Mon, 27 Mar 2023 22:44:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 43E288108;
        Tue, 28 Mar 2023 05:44:42 +0000 (UTC)
Date:   Tue, 28 Mar 2023 08:44:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     cgel.zte@gmail.com
Cc:     khilman@kernel.org, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] ARM: OMAP2+: Remove the unneeded result
 variable
Message-ID: <20230328054441.GL7501@atomide.com>
References: <20220920065113.215685-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920065113.215685-1-ye.xingchen@zte.com.cn>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* cgel.zte@gmail.com <cgel.zte@gmail.com> [220920 09:43]:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value amx3_common_init() directly instead of storing it in
> another redundant variable.

Thanks applying into omap-for-v6.4/cleanup.

Tony
