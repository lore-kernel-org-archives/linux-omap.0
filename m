Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE90C433ED
	for <linux-omap@archiver.kernel.org>; Wed,  5 May 2021 11:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D152610A7
	for <linux-omap@archiver.kernel.org>; Wed,  5 May 2021 11:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhEELOe (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 5 May 2021 07:14:34 -0400
Received: from muru.com ([72.249.23.125]:51898 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232884AbhEELO2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 5 May 2021 07:14:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 319F080DB;
        Wed,  5 May 2021 11:13:00 +0000 (UTC)
Date:   Wed, 5 May 2021 14:12:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Subject: Re: [PATCHv2] drm/omap: Fix issue with clocks left on after resume
Message-ID: <YJJ9twsxdw2Mi0F6@atomide.com>
References: <20210428092500.23521-1-tony@atomide.com>
 <YIlsy4mOkLcbMKwr@pendragon.ideasonboard.com>
 <YIo6CzsU4JRvAdpb@atomide.com>
 <79bea9b8-b2d2-11ec-87a3-34626347e122@ideasonboard.com>
 <YI/UXqQbvdtC2HqI@atomide.com>
 <YI/bdLkwtUNFKHyW@atomide.com>
 <YI/p9Trr5tphov6q@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI/p9Trr5tphov6q@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [210503 12:18]:
> I think we still fix the dispc related issue too, otherwise the parent
> child_count will just keep increasing on each suspend. I check that
> again though.

After tons more debugging, I found the root cause for the parent child_count
increasing and posted a patch for it at [0] below.

This means the $subject patch here can be done later on as clean-up to
leave out lots of unnecessary PM runtime calls and simplify the system
suspend :)

Regards,

Tony


[0] https://lore.kernel.org/linux-pm/20210505110915.6861-1-tony@atomide.com/T/#u
