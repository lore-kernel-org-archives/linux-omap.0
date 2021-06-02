Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68128C47083
	for <linux-omap@archiver.kernel.org>; Wed,  2 Jun 2021 05:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD76108C
	for <linux-omap@archiver.kernel.org>; Wed,  2 Jun 2021 05:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFBFnl (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:43:41 -0400
Received: from muru.com ([72.249.23.125]:35192 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhFBFnk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 2 Jun 2021 01:43:40 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4FF84811B;
        Wed,  2 Jun 2021 05:42:04 +0000 (UTC)
Date:   Wed, 2 Jun 2021 08:41:54 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] usb: musb: Check devctl status again for a spurious
 session request
Message-ID: <YLcaIqqjtmizjRLL@atomide.com>
References: <20210518150615.53464-1-tony@atomide.com>
 <20210527211501.70d176b4@aktux>
 <YLCGZEan87yp9Eeq@atomide.com>
 <20210528113715.40ff1ff9@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528113715.40ff1ff9@aktux>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [210528 09:37]:
> rmmod omap2430 seems to bring back suspend current current to low
> currents. 

I wonder if the recent musb fix patch helps with this?

[PATCH] usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling
https://lore.kernel.org/lkml/20210528140446.278076-1-thomas.petazzoni@bootlin.com/

Regards,

Tony
