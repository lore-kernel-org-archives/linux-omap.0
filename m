From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 4/6] omap device tree changes for v3.13 merge window
Date: Mon, 14 Oct 2013 15:36:54 -0700
Message-ID: <87eh7n4gzd.fsf@linaro.org>
References: <5258a9a8.493e310a.779b.1b15SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:51171 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218Ab3JNWg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Oct 2013 18:36:57 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so7855682pbb.20
        for <linux-omap@vger.kernel.org>; Mon, 14 Oct 2013 15:36:57 -0700 (PDT)
In-Reply-To: <5258a9a8.493e310a.779b.1b15SMTPIN_ADDED_MISSING@mx.google.com>
	(Tony Lindgren's message of "Fri, 11 Oct 2013 18:44:58 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
>
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/dt-signed
>
> for you to fetch changes up to c49f4984fd45be36502e903e7a5a6a4faff42931:
>
>   Merge tag 'for_3.13/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.13/dt (2013-10-11 15:40:07 -0700)
>
> ----------------------------------------------------------------
>
> omap device tree related changes via Benoit Cousson <bcousson@baylibre.com>:
>
> Add the minimal DTS support for DRA7xx based SoC core.
> Add the initial support for N900 and gta04 phones.
> Enable USB3 on OMAP5 evm board.
> Add support for cryto accelerators
> Add new IGEP AQUILA board
> Add AM33XX EDMA support
> Update HSUSB node to use the reset-gpios fmwk

Thanks, pulled into next/dt.

Kevin
