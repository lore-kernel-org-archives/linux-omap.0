From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Wed, 11 Mar 2015 10:53:39 +0100
Message-ID: <3439869.6umCuOq6SV@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com> <20150310173550.GT5264@atomide.com> <CABxcv=ndnNj4MhoXeW=GHXT4aEWQYHdbu-Mg4R2Zhf9CJTrJCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62981 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbbCKJyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2015 05:54:12 -0400
In-Reply-To: <CABxcv=ndnNj4MhoXeW=GHXT4aEWQYHdbu-Mg4R2Zhf9CJTrJCA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Eliad Peller <eliad@wizery.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Wednesday 11 March 2015 02:00:59 Javier Martinez Canillas wrote:
> Hello Tony,
> 
> On Tue, Mar 10, 2015 at 6:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>
> >> we do have to make sure these wl18xx bindings are future-compatible
> >> with the wl12xx ones, but i think the current bindings are pretty much
> >> standard (and are actually a subset of the bindings needed by wl12xx),
> >> so it should be fine.
> >
> > Well how about add just the parsing of the clock and assume it's always
> > WL12XX_REFCLOCK_38 for now as that's the only thing we're currently
> > using. Then we can add a property or compatible value if using something
> > else as needed.
> >
> 
> What do you mean by parsing here? IIUC there isn't a clock driver for
> these clocks and are setup directly in the
> drivers/net/wireless/ti/wl12xx/main.c driver.
> 
> So you can't make the WLAN chip dev node a consumer of these clocks by
> adding a phandle to a clock provider and clock specifiers since there
> isn't a provider to be referenced in the DT. Or did I misunderstand?

As I understand it, the clock signal is provided by an external oscillator,
which we can easily model in DT, and then you call clk_get_rate on that.

If there is no external clock provider for this chip and the clocks
are provided by the device itself, then all we need is a clock-frequency
property in the device node.

	Arnd
