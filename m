From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 06 Jan 2015 09:38:23 -0800
Message-ID: <7hk30zzu5s.fsf@deeprootsystems.com>
References: <20150105230228.GO4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34764 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277AbbAFRi0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 12:38:26 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so31492307pac.39
        for <linux-omap@vger.kernel.org>; Tue, 06 Jan 2015 09:38:26 -0800 (PST)
In-Reply-To: <20150105230228.GO4081@atomide.com> (Tony Lindgren's message of
	"Mon, 5 Jan 2015 15:02:29 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

Tony Lindgren <tony@atomide.com> writes:

> Revert "ARM: dts: Disable smc91x on n900 until bootloader
> dependency is removed". We've now fixed the issues that
> caused problems with uninitialized hardware depending on
> the bootloader version. Mostly things got fixed with
> the following commits:
>
> 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
> 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
>
> Note that this only affects the early development boards
> with Ethernet that we still have in a few automated boot
> test systems.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Kevin Hilman <khilman@linaro.org>
