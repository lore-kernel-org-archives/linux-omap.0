From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH v2] OMAP3: PM: USBHOST: clear wakeup events on both hosts
Date: Sun, 19 Jul 2009 08:35:40 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039681E5E1@dlee02.ent.ti.com>
References: <1247877189-5754-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49139 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbZGSNfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 09:35:48 -0400
In-Reply-To: <1247877189-5754-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Friday, July 17, 2009 7:33 PM

> USBHOST module has 2 fclocks (for HOST1 and HOST2), only one iclock
> and only a single bit in the WKST register to indicate a wakeup event.
>
> Because of the single WKST bit, we cannot know whether a wakeup event
> was on HOST1 or HOST2, so enable both fclocks before clearing the
> wakeup event to ensure both hosts can properly clear the event.

Yes, if you need to clear bits clocks must be on.

Question which comes to mind is if the wakeup bit should have been set for target mode.  Ideally when this status is set the f-clk should have been already on.  Does USB framework even export good control of possible sleep modes...

Most WKST bits are used in conjunction with INACTIVE mode wakeup.  The exception to this is WAKUP-domain WKSTs which are also used in wakes from RET or OFF mode.

So point is... for USB having this WKST status bit set and NOT having the F-Clk enabled points to an issue in the OFF mode transition code in the USB driver.

Since the driver won't have access to PRCM registers the only places which can fix this issue today is the PRCM irq (like being proposed) or inside the clock-frame-work at the F-Clk shutdown point.

Generally if status is hanging around when you try to sleep, you will have a failed sleep.  Today what is happening is the prcm-irq will come and sweep up the status at some later time.  This will allow an eventual sleep success.

......

A - Sleeps states which don't require enumeration

TARGET: INACTIVE mode+wakeup-capable-to-usb-resume (mstandby asserted & dpll still requested) :: For USB, when it goes to USB-bus-suspend, if you want to wake on usb-bus-resume from the usb wake path, probably you would leave on the fclk.

TARGET: RET/OFF mode+wakeup-capapble+USB-SAR (mstandby asserted & no dpll requests) :: If you want to go to OFF or RET mode then you first move to usb-bus-suspend, then shut down f-clk, then setup for some io-ring wake event.

B - Sleep states which require enumeration on wake
-- mstandby must be asserted, however you can cheat to get there by using force-standby, forced-idle, then expect a full path reset and enumeration at wake up time.

.......

USB has a few state choices around sleep which it doesn't seem are well specified in code.  Just hooking to existing suspend/resume handlers which are meant more for 'B' handling caused issues if people are going for the 'A' behavior.

Regards,
Richard W.


