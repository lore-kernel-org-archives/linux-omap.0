Return-Path: <SRS0=3IKH=EG=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B7C4742C
	for <linux-omap@archiver.kernel.org>; Sat, 31 Oct 2020 07:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C42221534
	for <linux-omap@archiver.kernel.org>; Sat, 31 Oct 2020 07:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgJaHPo (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 31 Oct 2020 03:15:44 -0400
Received: from muru.com ([72.249.23.125]:47240 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgJaHPo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sat, 31 Oct 2020 03:15:44 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 671C280A3;
        Sat, 31 Oct 2020 07:15:48 +0000 (UTC)
Date:   Sat, 31 Oct 2020 09:15:39 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: motorola-mapphone-common: Add dts
 configureation for the android buttons beneath the screen
Message-ID: <20201031071539.GM5639@atomide.com>
References: <20201030100550.010bfe4f3cdc2f4e5a599c8b@uvos.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030100550.010bfe4f3cdc2f4e5a599c8b@uvos.xyz>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Carl Philipp Klemm <philipp@uvos.xyz> [201030 09:06]:
> Adds a driver for supporting permanet, physically labeled, buttons on
> touchscreen surfaces. As are common on android phones designed with android 1.0
> to 2.3 in mind. The driver works by attaching to another input device and
> creating key events on its device when a press is registerd on a button.
> It also provides a mirrored touchscreen device with the same events as the
> attached device, but with the touchches that land on buttons filterd away
> Buttons are arbitrary rectangles configurable via dts.

Nice to have a generic way for the touchscreen buttons :)

Care to summarize here too what's currently blocking touchscreen buttons
driver only providing the keyboard events as a separate inputdevice
without having to mirror all the touchscreen events?

Regards,

Tony

