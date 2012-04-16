From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi, regulator and mmc DTS
 updates
Date: Mon, 16 Apr 2012 11:00:35 -0700
Message-ID: <20120416180035.GJ6487@atomide.com>
References: <4F612C29.40608@ti.com>
 <20120315004638.GW12083@atomide.com>
 <201203150801.13183.arnd@arndb.de>
 <4F746CC0.9050507@ti.com>
 <CAOesGMg+xLrVNxF0XwO8poAtuduwEcxrXLN9pXa+T+y7kKMy7Q@mail.gmail.com>
 <CAOesGMjJMgQF9jUUUMbm22oaEzan6eLW+-kWN9iB85buJxp4Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65177 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab2DPSAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 14:00:42 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMjJMgQF9jUUUMbm22oaEzan6eLW+-kWN9iB85buJxp4Dg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org

* Olof Johansson <olof@lixom.net> [120414 18:22]:
> Benoit, Tony,
> 
> On Thu, Mar 29, 2012 at 11:31 AM, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, Mar 29, 2012 at 7:08 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> >> FYI, MMC DT adaptation just got merged, I2C, GPIO, SPI, regulator DT
> >> adaptation were already merged before, so it means that this branch can be
> >> merged to take advantage of all the DT adapted drivers.
> >
> > I've pulled this in as late/omap-dt, included in next/dt3 and
> > for-next. I'll let it sit in linux-next for at least one day before
> > it's sent in. Since it's just device tree additions, risk for
> > regressions should be low.
> 
> As you've noticed, this didn't make it into 3.4 due to the window
> closing early. :(
> 
> I've renamed the branch in arm-soc to omap/dt-missed-3.4 and merged it
> into next/dt for the 3.5 merge window.

OK, no problem. Thanks for the update.

Tony
