Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD595C4332F
	for <linux-omap@archiver.kernel.org>; Fri, 18 Nov 2022 08:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiKRIaD (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbiKRI3D (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2022 03:29:03 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FE4D109
        for <linux-omap@vger.kernel.org>; Fri, 18 Nov 2022 00:28:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4030E807E;
        Fri, 18 Nov 2022 08:18:47 +0000 (UTC)
Date:   Fri, 18 Nov 2022 10:28:51 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-omap@vger.kernel.org
Subject: Re: omap4-keypad mystery
Message-ID: <Y3dCQy3blizKD4NW@atomide.com>
References: <20221116231146.2edf8322@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116231146.2edf8322@aktux>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [221116 22:02]:
> Hi,
> 
> I am investigating how to use the omap4 keypad driver in dts and I am quite
> confused. Nobody seems to add any pinmux to it. Why?
> 
> I muxed the rows0-3 and cols0-3 to MODE1 without any wakeup.
> 
> When I set /sys/bus/platform/devices/4a31c000.keypad/power/control
> to on I get keypad interrupts and events in evtest. but with it set to auto,
> nothing happens. Setting the rows pinmux to 0x4119 instead of 0x119 does not
> change anything.
> 
> Nobody seems to add provisions to wake up independently of the keypad
> hwmod which seems to be odd. I would expect interrupt-extended along with
> the keypad definitions.

I think the keypad is in the wkup domain so it's always listening for
events like gpio1 instance. So there should not be any need for padconf
interrupts.

Regards,

Tony
