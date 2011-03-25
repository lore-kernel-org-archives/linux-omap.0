From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 25 Mar 2011 15:50:25 +0100
Message-ID: <201103251550.26117.arnd@arndb.de>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <201103251424.47141.arnd@arndb.de> <4D8C99CC.5020103@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51506 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab1CYOuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 10:50:37 -0400
In-Reply-To: <4D8C99CC.5020103@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andy.green@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com

On Friday 25 March 2011, Andy Green wrote:
> I see.  It would work OK then.  They probably wouldn't want to blow 
> their $1750 just on Panda though, so maybe they set 4 bits or whatever 
> and let 20 be computed.

Well, if the algorithm is defined well, it could be used for any device
based on OMAP. The marketing department could turn this into a win by
declaring "does not require external EEPROM for ethernet mac address" ;-)
 
> However, the only practical advantage is that it would show up as a TI 
> MAC in an OUI database.  The "locally administered" address as used at 
> the moment is otherwise legal in every respect AFAIK.

It should work almost always, except in very special corner cases:

* If you have a netboot setup, you want the boot loader to use the
same mac address for requesting the kernel image that you use later,
otherwise the switch might consider it a MAC spoofing attach and disable
the port. The obvious workaround is to put your code into the boot loader
as well.

* Some environments might be configured to disallow locally administered
MAC addresses for "security" reasons. A bit bogus, but not unheard of.

* Some places try to keep a database of all used machines and their MAC
addresses to monitor who connects to the network. This requires the address
to be stable. It also prevents the use of virtualization, so it's becoming
less common.

	Arnd
