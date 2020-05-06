Return-Path: <SRS0=JFcU=6U=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CC4C38A2A
	for <linux-omap@archiver.kernel.org>; Wed,  6 May 2020 14:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA5E20870
	for <linux-omap@archiver.kernel.org>; Wed,  6 May 2020 14:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgEFOnl (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 6 May 2020 10:43:41 -0400
Received: from muru.com ([72.249.23.125]:53038 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgEFOnl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 6 May 2020 10:43:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0B3B8807E;
        Wed,  6 May 2020 14:44:29 +0000 (UTC)
Date:   Wed, 6 May 2020 07:43:38 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz
Subject: Re: USB networking news, ofono for d4: less hacked version
Message-ID: <20200506144338.GT37466@atomide.com>
References: <20200506101125.GA7490@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506101125.GA7490@amd>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200506 10:12]:
> Hi!
> 
> So... I found out that USB networking works way better when I don't
> attempt to charge the phone at the same. Yes, green light was
> blinking.

OK yes we don't have much of a charger detection currently and the
charger tries to reconnect with the LED blinking rapidly with an
empty battery.

> To github.com:pavelmachek/ofono.git
>    e7b58fdd..1e7e5ce3  mux-v1.19-2 -> mux-v1.19-2
> 
> which creates copy of atchat, so I don't damage existing
> functionality. It still seems to somehow work. Lot more work is still
> needed. Designed to work with latest kernel patches from Tony, using
> gsmmux interfaces.

OK, sounds like that should work :) 

I still need to figure update audio notifications for the current set of
gsmmux patches. Eventually maybe ofono can just set the voice call audio
routing using alsa. But let's get the kernel notifications working first
as we also need to fix up the audio parts for the earlier comments from
Peter and Sebastian.

Regards,

Tony

