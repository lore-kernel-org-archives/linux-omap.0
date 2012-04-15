From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi, regulator and mmc DTS updates
Date: Sat, 14 Apr 2012 18:19:09 -0700
Message-ID: <CAOesGMjJMgQF9jUUUMbm22oaEzan6eLW+-kWN9iB85buJxp4Dg@mail.gmail.com>
References: <4F612C29.40608@ti.com>
	<20120315004638.GW12083@atomide.com>
	<201203150801.13183.arnd@arndb.de>
	<4F746CC0.9050507@ti.com>
	<CAOesGMg+xLrVNxF0XwO8poAtuduwEcxrXLN9pXa+T+y7kKMy7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47357 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558Ab2DOBTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Apr 2012 21:19:10 -0400
Received: by wgbdr13 with SMTP id dr13so4114934wgb.1
        for <linux-omap@vger.kernel.org>; Sat, 14 Apr 2012 18:19:09 -0700 (PDT)
In-Reply-To: <CAOesGMg+xLrVNxF0XwO8poAtuduwEcxrXLN9pXa+T+y7kKMy7Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org

Benoit, Tony,

On Thu, Mar 29, 2012 at 11:31 AM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Mar 29, 2012 at 7:08 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> FYI, MMC DT adaptation just got merged, I2C, GPIO, SPI, regulator DT
>> adaptation were already merged before, so it means that this branch can be
>> merged to take advantage of all the DT adapted drivers.
>
> I've pulled this in as late/omap-dt, included in next/dt3 and
> for-next. I'll let it sit in linux-next for at least one day before
> it's sent in. Since it's just device tree additions, risk for
> regressions should be low.

As you've noticed, this didn't make it into 3.4 due to the window
closing early. :(

I've renamed the branch in arm-soc to omap/dt-missed-3.4 and merged it
into next/dt for the 3.5 merge window.


-Olof
