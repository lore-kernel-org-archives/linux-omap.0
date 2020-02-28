Return-Path: <SRS0=ohbF=4Q=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B0C3F2D2
	for <linux-omap@archiver.kernel.org>; Fri, 28 Feb 2020 18:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EE2246AE
	for <linux-omap@archiver.kernel.org>; Fri, 28 Feb 2020 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgB1SE0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:04:26 -0500
Received: from muru.com ([72.249.23.125]:58290 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1SEZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 28 Feb 2020 13:04:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 84557806C;
        Fri, 28 Feb 2020 18:05:10 +0000 (UTC)
Date:   Fri, 28 Feb 2020 10:04:22 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>, ruleh <ruleh@gmx.de>
Subject: Re: [PATCHv2 0/3] Lost key-up interrupt handling for omap4-keypad
Message-ID: <20200228180422.GN37466@atomide.com>
References: <20200228171223.11444-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228171223.11444-1-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200228 17:13]:
> I can still reproduce one issue where a fast shift-shift-j can produce an
> upper case J instead of j for example. This seems unrelated to the controller
> idling with state issue probably, maybe it's some debouncing related issue.
> So far playing with the debouncing configuration has not helped with this
> issue though. Anyways, please test if you're seeing stuck keys on droid4.

Oh so turns out this can be dealt with by first scanning for any lost
key-up events. I just sent out patch 4/3 to this series to fix that.

Regards,

Tony
