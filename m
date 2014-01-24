From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Fri, 24 Jan 2014 21:37:53 +0100
Message-ID: <52E2CF21.2020304@epfl.ch>
References: <52e06652.c103450a.79d7.6517@mx.google.com> <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com> <52E0B569.8000809@ti.com> <52E0CF58.5040109@epfl.ch> <52E0DA13.9090302@ti.com> <52E0DD9F.8000100@epfl.ch> <52E0E3D1.5050202@epfl.ch> <52E10AB4.9060002@ti.com> <52E144BC.4000900@epfl.ch> <52E1527E.8020509@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:40688 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbaAXUiA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 15:38:00 -0500
In-Reply-To: <52E1527E.8020509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "tony@atomide.com" <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ash Charles <ash@gumstix.com>

Hi,

On 01/23/2014 06:33 PM, Nishanth Menon wrote:
> On 01/23/2014 10:35 AM, Florian Vaussard wrote:
>>
> 
> [..]
>>
>> Ok, so with your patch and changing the include from omap34xx to
>> omap36xx, it works. Now I have to come up with a way to manage all the
>> versions without duplicating all the DT files :-(
> 
> you'd also want to be careful about the omap3_pmx_core2 Vs
> omap3_pmx_core2 split for padconf.
> 

Yes, I know that this is another problematic point. I guess that I will
end up splitting all 34xx-specific and 36xx-specific parts into
dedicated files. Unless I can figure out a way to magically compute the
offset inside the pinctrl domain, but I doubt. I will try to contain the
omap3_pmx_core2 pins to omap3-overo, away from the expansion boards.

> options that come to mind are:
> a) split omap3-overo.dtsi into omap3-overo-common.dtsi
> omap3-overo-34xx.dtsi,omap3-overo-36xx.dtsi, corresponding tobi board
> dts file include as needed
> b) only have common stuff in omap3-overo.dtsi, include omap34xx.dtsi
> or omap36xx.dtsi in corresponding tobi board dts.
> 

Yes, both are an option. I don't know if b) can work, as
omap3-overo.dtsi maybe depends on features declared in omap3yxx.dtsi (to
be verified).

The main problem with both options is that Tobi is not the only
expansion board (the only mainlined for now). I sent patches for other
expansion boards a couple of days ago [1], so at the end we may have ~10
boards if you count only Gumstix's boards, not to mention the boards
from other people (like me). So finally, we will double the number of
dts files just to support both variants. I hope that Gumstix will not
produce a third version of the Overo.

Maybe I can use dt overlay for the expansion boards, like what is done
for capes with beaglebone. The expansion board's overlay could be
applied to the correct Overo dtb at runtime, like what is done from the
hardware's point of view.

I am not familiar with overlays, but from my rapid analysis, the main
difference is: cape's overlay is fused by the userspace when the kernel
has booted, whereas Overo's expansion boards must be fused early in the
boot process (or by the bootloader), as they provide some essential
services, like the primary NIC. I need more time to explore the
feasibility of this solution.

Regards,

Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/109589
