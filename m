From: Daniel Seifert <dseifert@gmx.de>
Subject: Re: OMAP watchdog broken on 37XX?
Date: Sun, 26 Jun 2011 23:52:26 +0200
Message-ID: <BANLkTi=WQzdfOXqYWGe8gFjrn=kHbg-2eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:50527 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754649Ab1FZVwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jun 2011 17:52:51 -0400
Received: by ywe9 with SMTP id 9so1645923ywe.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Jun 2011 14:52:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

On Fri, 10 Jun, Steve Sakoman wrote:
> I've used the omap watchdog timer (CONFIG_OMAP_WATCHDOG=y &
> CONFIG_WATCHDOG_NOWAYOUT=y) with good results on 35XX based systems.
>
> Recently I attempted to use the the same technique with 37XX and
> discovered that my systems hangs instead of rebooting.
>
> The simplest method to test is to do:
>
> # echo 1 > /dev/watchdog
> omap_wdt: Unexpected close, not stopping!
>
> On 35XX the system will reboot in one minute as expected.
>
> On 37XX the system the systems hangs in one minute.
>
> Has anyone else encountered this?

Yes, I experience the same problem. On a 35xx board the watchdog
worked fine, but on a DM3730 one it just freezes up. Tried with 2.6.35
and 3.0.0-rc3-g19a1166 (omap2plus defconfig). Has anybody seen a patch
for this yet?

Daniel
