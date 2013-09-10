From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: omap2: throw the die id into the entropy pool
Date: Tue, 10 Sep 2013 10:20:48 +0200
Message-ID: <CACRpkdartxUGNqNkpymecaTrgVrkcDTg9UN7LRiCVRcwnE01Og@mail.gmail.com>
References: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org>
	<alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:56968 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab3IJIUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 04:20:48 -0400
Received: by mail-ie0-f180.google.com with SMTP id 10so12313610ied.39
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 01:20:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>

On Mon, Sep 9, 2013 at 9:14 PM, Paul Walmsley <paul@pwsan.com> wrote:

> Heh, that function name "add_device_randomness()" is a bit misleading.
> It's not actually intended to add "randomness": from
> drivers/char/random.c:

Yeah you're right...

Tony feel free to edit the commit message when applying.

>  * None of this adds any entropy, it is meant to avoid the
>  * problem of the nonblocking pool having similar initial state
>  * across largely identical devices.

It's noble enough, just a few years back I ran into the problem where
all boards in a test farm came up with the same ethernet MAC
address due to the initialization of the nonblocking pool being
constant.

Yours,
Linus Walleij
