From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: am437x-gp-evm: add support for parallel
 NAND flash
Date: Wed, 7 May 2014 14:19:49 -0700
Message-ID: <20140507211949.GA19102@atomide.com>
References: <1398152020-19391-1-git-send-email-pekon@ti.com>
 <1398152020-19391-3-git-send-email-pekon@ti.com>
 <20140506153956.GE18474@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EACB432@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58673 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbaEGVTy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 17:19:54 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACB432@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>

* Gupta, Pekon <pekon@ti.com> [140507 12:20]:
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >>* Pekon Gupta <pekon@ti.com> [140422 00:34]:
> >> +&gpmc {
> >> +	status = "okay";
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&nand_flash_x8>;
> >> +	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
> >
> >Please use the minimum size 16MB GPMC range here, NAND only
> >has few registers addressable unlike NOR that actually uses the
> >whole range.
> >
> >> +	nand@0,0 {
> >> +		reg = <0 0 0>; /* CS0, offset 0 */
> >
> >Then here map the true size of the NAND device IO register area.
> >
> >BTW, we should do the similar changes to other files so we can
> >unify the GPMC partitioning a bit. But that's unsafe to do until
> >we have fixed the issue of mapping GPMC devices to a different
> >location from the bootloader location.
> >
> I have found the fix of this issue in gpmc_cs_remap() just testing it
> using beaglebone NOR cape. I'll post that separately, once I'm confident.

OK that's great. Yet another issue I've noticed is that u-boot
seems to program 37xx L3 to run at 200 MHz and the LAN9220
timings overflow the GPMC registers as 200 / 5 >= 32.
 
> But for now, I'll re-send just these patches for NAND DT node with
> your feedbacks incorporated, so that NAND is stable on these
> platforms / boards from 3.16 onwards.

OK sounds good to me.

Tony
