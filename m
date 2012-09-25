From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI
	AM33XX
Date: Tue, 25 Sep 2012 09:14:49 +0100
Message-ID: <20120925081449.GF31374@n2100.arm.linux.org.uk>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com> <20120924171858.GG28835@atomide.com> <CAGm1_ks_GvSTH8DJ6d3R5OjPNEOhQ39hNo4grg1Pn-NqFX5VKQ@mail.gmail.com> <20120924231619.GA28941@n2100.arm.linux.org.uk> <20120925003758.GP28835@atomide.com> <506165CA.7070406@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39659 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab2IYIO6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 04:14:58 -0400
Content-Disposition: inline
In-Reply-To: <506165CA.7070406@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: Tony Lindgren <tony@atomide.com>, Yegor Yefremov <yegorslists@googlemail.com>, linux-omap@vger.kernel.org, Dejan Gacnik <dejan.gacnik@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Sep 25, 2012 at 10:05:30AM +0200, Yegor Yefremov wrote:
> How should I change the patch to make it proper? SA1111 is broken anyway:

No it isn't.  This is what it produces _today_, and has done for the last
5-10 years without modification

# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_FORCE_MAX_ZONEORDER=9
CONFIG_LEDS=y
CONFIG_LEDS_CPU=y

> config FORCE_MAX_ZONEORDER
>         int "Maximum zone order" if ARCH_SHMOBILE
>         range 11 64 if ARCH_SHMOBILE
>         default "9" if SA1111
>         default "11"
> 
> AFAIK if ARCH_SHMOBILE defines dependency on ARCH_SHMOBILE,

No it doens't.

	int "Maximum zone order" if ARCH_SHMOBILE

is far from being the same as:

	int "Maximum zone order"
	depends on ARCH_SHMOBILE

The former defines a condition upon which the option is offered in GUIs -
or to put it another way, it defines the visibility of the option.

The latter defines a dependency which must be met for the option to be
both visible and appear in the resulting configuration file.

> so SA1111 won't be evaluated (at least if I select SA1111

And did you check that SA1111 remains selected?  I bet you didn't.  Or
maybe you tested your patched version.  Whatever.  The original works,
and has been known to work for years.  Your patch breaks it.  It's
really as simple as that.
