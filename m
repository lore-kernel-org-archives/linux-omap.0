From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.12
Date: Fri, 23 Aug 2013 11:31:04 -0700
Message-ID: <87fvu0mf87.fsf@linaro.org>
References: <521384D5.1050607@baylibre.com>
	<20130821071334.GQ7656@atomide.com> <5214D4FD.4060405@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53415 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab3HWSbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Aug 2013 14:31:12 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so994555pad.33
        for <linux-omap@vger.kernel.org>; Fri, 23 Aug 2013 11:31:11 -0700 (PDT)
In-Reply-To: <5214D4FD.4060405@baylibre.com> (Benoit Cousson's message of
	"Wed, 21 Aug 2013 16:55:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Benoit Cousson <bcousson@baylibre.com> writes:

> Hi Kevin & Olof,
>
> I've just updated the branch with the few USB3 patches I missed from Felipe.
>
> So here is a new pull-request.
>
> Thanks,
> Benoit
>
> ----------------------------------------------------------------
> Add the minimal DTS support for DRA7xx based SoC core.
> Add the initial support for N900 and gta04 phones.
> Enable USB3 on OMAP5 evm board.
> Do a lot of various cleanups.
> ----------------------------------------------------------------

This is a nice description, but would be even better if it was the
description of the signed tag.  For future pulls, since we're pulling
from you directly into arm-soc, can you start using signed tags please?


> The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:
>
>   Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.12/dts
>
> for you to fetch changes up to 5903208d4e2c09a3872feba6b9e2e49c64fd07ad:
>
>   ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies (2013-08-21 16:43:21 +0200)
>

Pulled into next/dt.

Benoit, since we're pulling directly from you into arm-soc, can you
start using signed tags please?  Thanks.

Kevin
