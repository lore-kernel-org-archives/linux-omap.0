From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/11] pinctrl: single: Clear pin interrupts enabled by bootloader
Date: Wed, 23 Apr 2014 15:57:31 +0200
Message-ID: <CACRpkdZeUTugwxaxCUBDVE3b+ak21m8C2Ff4N5rZ3+i5OdQXyA@mail.gmail.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
	<1397173639-29587-12-git-send-email-tony@atomide.com>
	<CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
	<20140422161033.GC19317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:57112 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaDWN5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 09:57:32 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so1051984oag.3
        for <linux-omap@vger.kernel.org>; Wed, 23 Apr 2014 06:57:31 -0700 (PDT)
In-Reply-To: <20140422161033.GC19317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>

On Tue, Apr 22, 2014 at 6:10 PM, Tony Lindgren <tony@atomide.com> wrote:

>> Shall I apply this patch or will you funnel it through ARM SoC
>> due to deps?
>
> No deps except boards hanging without it.. Please feel free to
> take this one, prererrably as a fix for the -rc series if no
> objections.

Yes this is -rc material. Queued for fixes. Thanks!

Yours,
Linus Walleij
