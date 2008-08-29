From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Pin mux utility?
Date: Fri, 29 Aug 2008 20:21:09 +0300
Message-ID: <1220030469.19671.7.camel@localhost>
References: <5e088bd90808290756k7c91d2dbu8e6593788d6a5d07@mail.gmail.com>
	 <200808291017.40151.david-b@pacbell.net>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65147 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYH2RdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 13:33:09 -0400
In-Reply-To: <200808291017.40151.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
On Fri, 2008-08-29 at 10:17 -0700, ext David Brownell wrote:
> On Friday 29 August 2008, Steve Sakoman wrote:
> > Is anyone aware of a utility to report the state of pin mux settings?
> > 
> > I'd like to verify that u-boot is setting things up properly.
> 
> CONFIG_OMAP_MUX_WARNINGS helps for some definitions of "properly":
> when Linux needs one setting, but the boot loader leaves a different
> one, you get a warning.  That's usually interpreted as u-boot doing
> it wrong, except on devboards where the boot loader can't actually
> know about all external hardware that might be hooked up (and how)

I'm probably a bit off topic, but since Tony started promoting the
concept of multi-arch binary, well, i see it as a huge limitation the
fact that the bootloader is expected to the right thing.

When thinking about our Nokia HW vs the TI SDP, even the bootloader is
different (yes, we should move to uboot and i couldn't be happier, but
it's not gonna happen at the moment).

In the multi arch case (but even single-arch, if we would like to
support multiple boards with one single kernel binary) i see as a much
more reasonable solution the case where the bootloader passes the board
id to the kernel and the kernel loads the board-specific configuration
in the form of a module.

DVFS for example defeats the idea that the bootloader would be enough to
setup properly the clock tree (of course it will do it, but only for 1
OP and the setting can get lost the first time another OP is selected).

Imho the bootloader should just do what the name suggests: load the
kernel and boot it. In as minimal configuration as possible.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
