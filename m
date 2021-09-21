Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29111C433F5
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 07:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067E461175
	for <linux-omap@archiver.kernel.org>; Tue, 21 Sep 2021 07:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhIUHBq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 21 Sep 2021 03:01:46 -0400
Received: from muru.com ([72.249.23.125]:35218 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhIUHBp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 21 Sep 2021 03:01:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 830C480A8;
        Tue, 21 Sep 2021 07:00:44 +0000 (UTC)
Date:   Tue, 21 Sep 2021 10:00:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc:     linux-omap@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: Regression with e428e250fde6 on BeagleBoard Rev C2
Message-ID: <YUmC/xbYDnXMrsb1@atomide.com>
References: <3f6924a7-1934-b94e-2441-4781fe737f32@bitmer.com>
 <YUiOA4QEbZXPmQ7F@atomide.com>
 <5de5382b-9f11-c99b-5b9b-c90ae023e10b@bitmer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de5382b-9f11-c99b-5b9b-c90ae023e10b@bitmer.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [210920 16:35]:
> On 9/20/21 4:34 PM, Tony Lindgren wrote:
> > The patch below should take us back to the earlier configuration,
> > can you please give it a try?
> > 
> I double checked and unfortunate it doesn't boot at all or give any
> output when patch is applied:

Hmm I tested it with copying the beagle timer configuration to omap3.dtsi
and things worked for me. If you can, please try adding
CONFIG_SERIAL_EARLYCON=y and then also add "debug earlyprintk" to kernel
command line. It might show something that I'm not able to reproduce.
Maybe there is a bootloader dependency or something like that.

It should be OK to keep these options enabled, except maybe not for
"debug" in the command line.

Regards,

Tony
