From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 09:00:26 +0100
Message-ID: <20150106080025.GA6752@amd>
References: <20150105230228.GO4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44626 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbAFIA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 03:00:28 -0500
Content-Disposition: inline
In-Reply-To: <20150105230228.GO4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> Revert "ARM: dts: Disable smc91x on n900 until bootloader
> dependency is removed". We've now fixed the issues that
> caused problems with uninitialized hardware depending on
> the bootloader version. Mostly things got fixed with
> the following commits:
> 
> 9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
> 7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")
> 
> Note that this only affects the early development boards
> with Ethernet that we still have in a few automated boot
> test systems.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Normally, the early development boards should have separate dts file
(then include common parts), no?

Could you at least add a note to the dts file what is it? Because I
always thought it is a bug.

[Plus of course, obviouse question is: where can I get one of those
boards? :-)]

									Pavel

> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -702,9 +702,6 @@
>  
>  	ethernet@gpmc {
>  		compatible = "smsc,lan91c94";
> -
> -		status = "disabled";
> -
>  		interrupt-parent = <&gpio2>;
>  		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
>  		reg = <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
