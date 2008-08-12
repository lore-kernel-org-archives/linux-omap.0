From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: RE: off mode and smartreflex
Date: Tue, 12 Aug 2008 15:57:50 +0300
Message-ID: <1218545870.8751.31.camel@kj-ubuntu>
References: <20080801100024.GB8857@codecarver.research.nokia.com>
	 <13B9B4C6EF24D648824FF11BE89671620361E3890B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48398 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYHLMzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 08:55:14 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361E3890B@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Richard,

On pe, 2008-08-01 at 09:49 -0500, ext Woodruff, Richard wrote:
> Hi Peter,
> 
> > Using Rajendra's cpuidle and offmode patches + the patches I posted
> to
> > configure triton2 and set the correct off mode polarity, I noticed
> the
> > system does not go to off mode when smartreflex is enabled. At least
> > sysoffmode is not deasserted and the VDD1 and VDD2 voltages do not
> > drop
> > to 0V. Should smartreflex be disabled by sw before the wfi is
> issued ?
> > Any other idea on why this would happen ?
> 
> SR does need to be disabled before an OPP change and re-enabled after
> the change when using the bypass method.
> 
> Yes, I do think you also need to disable SR before idle.  Also, this
> is in CDP code and functionally validated.

I thought I'd fix this issue for both pm-idle and the up-coming cpu-idle
by moving the smartreflex disable/enable calls to omap_sram_idle. But I
could not do it, because this way the device hangs on both suspend and
dynamic idle. I wonder why this is? 

The CDP code seems to disable smartreflex in the early stages of the
function calling omap_sram_idle. In the suspend path the disable call is
made just before local_fiq_disable. In pm-idle path the call seems to be
before checking if some interrupt has occurred. So I gathered this might
have something to do with interrupts.

The thing that puzzles me is that with linux-omap, the suspend path does
not have any local_fiq_disable calls. Nevertheless, if the smartreflex
disable call is in omap_sram_idle, the suspend hangs. But, if it is in
start of the preceding omap3_pm_suspend call, as it is now, suspending
works fine. So this makes me think there could be some delay from when
smartreflex is disabled to when the actual I2C commands stop to the
voltage controller.

Do you know why the smartreflex disable calls are positioned as they are
in the CDP code?

regards,
Kalle

> 
> Regards,
> Richard W.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
