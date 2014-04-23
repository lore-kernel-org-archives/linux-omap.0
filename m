From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Boot fixes
Date: Wed, 23 Apr 2014 07:59:05 -0700
Message-ID: <20140423145904.GB4833@atomide.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
 <20140422190132.GA12204@atomide.com>
 <5356C8AE.3090907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15728 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbaDWO7M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 10:59:12 -0400
Content-Disposition: inline
In-Reply-To: <5356C8AE.3090907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, bcousson@baylibre.com, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

* Dave Gerlach <d-gerlach@ti.com> [140422 12:53]:
> On 04/22/2014 02:01 PM, Tony Lindgren wrote:
> >* Dave Gerlach <d-gerlach@ti.com> [140422 11:52]:
> >>This patch, along with patch here [1], fixes boot for am437x-gp-evm. The
> >>bootloader configures gpio5_7 to control the DDR3 termination regulator,
> >>the linked patch prevents that gpio bank from being reset and losing
> >>the previously configured state, and this patch binds the gpio to a
> >>regulator so the kernel is aware of the state of the gpio.
> >>
> >>[1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg102941.html
> >
> >Setting up the GPIO regulator makes sense to me. But the hack in the
> >link above is potentially a nasty time bomb for anybody trying to
> >use GPIO bank 5 on that board.
> >
> >What tests have been done that the GPIO bank behaves properly when
> >it's not reset?
> 
> We've been using this configuration on this board for a while without any
> apparent issues. Also, am335x-evmsk already uses the same idea for the VTT
> regulator on board from commit 6046adb6ad701026c10adeac8d6a4138895f12e5
> [ARM: dts: am335x-evmsk: Do not reset gpio0] and I am unaware of any issues
> with that either.

OK. Do you have other GPIOs in use as interrupts for devices in these
banks and do they work fine?

Also, can you please test to make sure this works with the most recent
Javier's GPIO patches that had the issue of not booting on am335x-evmsk?

Regards,

Tony
