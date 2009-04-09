From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: 2.6.29 and SDP3430
Date: Thu, 9 Apr 2009 13:32:27 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFFB1EEE1@dlee02.ent.ti.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com>
 <20090409100343.71d34c16.jarkko.nikula@nokia.com>
 <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54478 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165AbZDISck convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 14:32:40 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037BCF18A5@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Woodruff, Richard
> Sent: Thursday, April 09, 2009 8:00 AM
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Jarkko Nikula
> > Sent: Thursday, April 09, 2009 2:04 AM
> 
> > > just messing around with tony's master branch on SDP3430, just did a
> > > defconfig and a build with  2007q3-51 codesourcery compiler, I see it
> > > hang around:
> > >
> > Kernels built with this compiler stuck into delay loop calibration.
> > No idea why, but 2008q3-66 was working for me.
Using the following:
arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2008q3-72) 4.3.2

I am past the lockup on calibration, but it now gets stuck as follows:
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Disabling unused clock "gpt2_ick"
Disabling unused clock "gpt2_fck"
Disabling unused clock "wdt2_ick"
Disabling unused clock "wdt2_fck"
Disabling unused clock "dpll4_m6x2_ck"
Disabling unused clock "dpll4_m5x2_ck"
Disabling unused clock "dpll3_m3x2_ck"
Disabling unused clock "sys_clkout1"
variant c rev 1
implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VAUX3 on


> 
> I wonder if the timer stopped ticking.  If you connect with emulator take
> a look at GPT1 registers and see if time base is moving.
> 
> Another quick test is to shut off tickles, nohz=off.
nohz=off did not work with either 2007q3 or 2008q3.. have'nt looked at the GPT regs though..

Regards,
Nishanth Menon
