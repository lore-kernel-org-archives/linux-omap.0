From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap4-panda-common: Fix pin muxing for
 wl12xx
Date: Wed, 27 Nov 2013 15:47:59 -0800
Message-ID: <20131127234759.GF26766@atomide.com>
References: <1385041804-19115-1-git-send-email-balajitk@ti.com>
 <1385041804-19115-2-git-send-email-balajitk@ti.com>
 <20131121165823.GM10317@atomide.com>
 <528E4295.2040109@ti.com>
 <20131126215537.GO26766@atomide.com>
 <52961DF2.8080507@ti.com>
 <20131127164823.GX26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64471 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754085Ab3K0XsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 18:48:03 -0500
Content-Disposition: inline
In-Reply-To: <20131127164823.GX26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Dan Murphy <dmurphy@ti.com>, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131127 08:49]:
> * Balaji T K <balajitk@ti.com> [131127 08:30]:
> > On Wednesday 27 November 2013 03:25 AM, Tony Lindgren wrote:
> > >* Dan Murphy <dmurphy@ti.com> [131121 09:28]:
> > >>On 11/21/2013 10:58 AM, Tony Lindgren wrote:
> > >>>* Balaji T K <balajitk@ti.com> [131121 05:51]:
> > >>>>pin mux wl12xx_gpio and wl12xx_pins should be part of omap4_pmx_core
> > >>>>and not omap4_pmx_wkup. So, move wl12xx_* to omap4_pmx_core.
> > >>>>
> > >>>>Fix the following error message:
> > >>>>pinctrl-single 4a31e040.pinmux: mux offset out of range: 0x38 (0x38)
> > >>>>pinctrl-single 4a31e040.pinmux: could not add functions for pinmux_wl12xx_pins 56x
> > >>
> > >>Why is the led pins moved then?
> > >
> > >Heh the patch just looks that way, looking at the curly brackets
> > >thing do get moved properly.
> > >
> > >>>>SDIO card is not detected after moving pin mux to omap4_pmx_core since
> > >>>>sdmmc5_clk pull is disabled. Enable Pull up on sdmmc5_clk to detect SDIO card.
> > >>>Cool, does this fix the issue with the WLAN not coming up after a warm reset
> > >>>on panda?
> > >
> > >Also commit f446043f1aa7 (regulator: fixed: fix regulator_list_voltage() for
> > >regression) is needed that recently got merged. But with v3.13-rc1 +
> > >f446043f1aa7 + this patch no luck whatsoever bringing up the wl12xx so there
> > >must be also some regression somewhere from v3.12 on that?
> > >
> > Hi Tony,
> > 
> > I tried loading wl12xx as modules on latest base as yours with
> > ti-connectivity/wl127x-fw-5-sr.bin firmware in place and I could connect
> > and run iperf.
> 
> Oh OK I must have missed something then.
> 
> Does it now work after a warm reboot too? And after bringing the interface
> down with "ifconfig wlan0 down" followed by "ifconfig wlan0 up"?

Yes great, I can confirm that v3.13-rc1 + f446043f1aa7 (regulator: fixed: fix
regulator_list_voltage() for regression) + this patch works even after a
warm reset :) Will apply both to omap-for-v3.13/fixes-take4 with Cc stable.

Regards,

Tony
