Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4590C433EF
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 07:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1716115B
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 07:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhIUHDw (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:03:52 -0400
Received: from muru.com ([72.249.23.125]:35246 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhIUHDw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 21 Sep 2021 03:03:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 26C1E80A8;
        Tue, 21 Sep 2021 07:02:52 +0000 (UTC)
Date:   Tue, 21 Sep 2021 10:02:22 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: Regression with e428e250fde6 on BeagleBoard Rev C2
Message-ID: <YUmDfrqBzCWlAQcz@atomide.com>
References: <3f6924a7-1934-b94e-2441-4781fe737f32@bitmer.com>
 <3C216B2C-5D6B-489C-A9D8-D14880EC91B7@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C216B2C-5D6B-489C-A9D8-D14880EC91B7@goldelico.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [210920 18:20]:
> Another effect I have seen is that heartbeat (I think it is a local patch
> I have in our devicetree) stops and toggles almost each time I press the enter
> key on the serial console.

Yeah this would be the case if the clockevent is not working properly.
I assume this is with beagleboard rev c2 and not on other boards?

Regards,

Tony
