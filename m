Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78158C47082
	for <linux-omap@archiver.kernel.org>; Sat,  5 Jun 2021 05:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DFE6138C
	for <linux-omap@archiver.kernel.org>; Sat,  5 Jun 2021 05:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFEFUF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 5 Jun 2021 01:20:05 -0400
Received: from muru.com ([72.249.23.125]:36556 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhFEFUF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sat, 5 Jun 2021 01:20:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BEB868167;
        Sat,  5 Jun 2021 05:18:24 +0000 (UTC)
Date:   Sat, 5 Jun 2021 08:18:14 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] usb: musb: Check devctl status again for a spurious
 session request
Message-ID: <YLsJFqYQQ9e233QQ@atomide.com>
References: <20210518150615.53464-1-tony@atomide.com>
 <20210527211501.70d176b4@aktux>
 <YLCGZEan87yp9Eeq@atomide.com>
 <20210604103533.6392beeb@aktux>
 <YLn06uuntThMlaTQ@atomide.com>
 <20210604185943.3efa2a19@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604185943.3efa2a19@aktux>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [210604 17:00]:
> On Fri, 4 Jun 2021 12:39:54 +0300
> Tony Lindgren <tony@atomide.com> wrote:
> > Does the following patch fix things for you or does something else break again? :)
> > 
> sigh,..
> ok, it breaks something. gadget (at least ecm) only works if
> musb/phy stuff is loaded, ecm configured via configfs
> rmmod omap2430
> modprube 2430
> 
> until the next usb disconnect
> and another rmmod/modprobe is required.

Hmm I don't follow, do you mean there's now another issue after a
system suspend? Or is this issue not related to system suspend and
resume?

> The following musb patches were applied additional to that one you
> added to this mail on top of 5.13-rc4.
> 
> usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling
> usb: musb: Add missing PM suspend and resume functions for 2430 glue
> usb: musb: Check devctl status again for a spurious session request

Does one of the above cause some additional usb gadget issue?

Regards,

Tony
