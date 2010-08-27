From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/9] omap: mux: Add new style pin multiplexing code for
 omap3
Date: Fri, 27 Aug 2010 11:24:37 +0200
Message-ID: <4C778455.8050108@ti.com>
References: <S1752576Ab0H0BhI/20100827013708Z+1681@vger.kernel.org> <1282876196.13328.45.camel@I097020.innocomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622Ab0H0JYo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Aug 2010 05:24:44 -0400
In-Reply-To: <1282876196.13328.45.camel@I097020.innocomm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rockefeller <rockefeller.lin@innocomm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 8/27/2010 4:29 AM, rockefeller wrote:
> Hi Tony,
>     In the implementation of omap_mux_init_signal(char *muxname, int val)
> in arch/arm/mach-omap2/mux.c, it will modify the muxname of
> caller that passed in and not recover it, did you mean to implement
> to do so?(I try to explain my point of view as 2 examples below).

I'm not sure it was really done on purpose. It works today because none 
of the following cases are really happening.

>
> [Example 1]
> For a XIP device(NOR type), a caller function might be codeed like
> below:
>
> omap_mux_init_signal("muxname.mode7", 0xFFFF);
>
> and in this case, the string "muxname.mode7" might be a const string
> and not be modified.

That case seems to be a valid one.

>
> [Example 2]
> For a NAND device, a caller might be coded like below:
>
> static char *pin_mux_name = "muxname.mode7";
>
> function1()
> {
> omap_mux_init_signal(pin_mux_name, 0xFFFF);
> }
>
> function2()
> {
> omap_mux_init_signal(pin_mux_name, 0x0000);
> }
>
> void main()
> {
> function1();
> function2();
> }
>
> Because "muxname.mode7" in in RAM is modifiable, after function call
> to function1(), the *pine_mux_name will be "muxname" and therefore when
> calls to function2() to try to set this pin in mode7 with value 0x0000
> might be un-expected result.

In theory the pin mux is done once at init time, so I'm not sure this 
case is supposed to happen. Is it a real case?

Anyway, I think that a simple strlcpy(tmp, muxname, 32) in 
omap_mux_init_signal can fix it.

Do you mind submitting a patch to fix that?

Thanks,
Benoit
