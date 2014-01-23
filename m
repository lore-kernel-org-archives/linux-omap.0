From: Tero Kristo <t-kristo@ti.com>
Subject: Re: next boot: 34 pass, 5 fail (next-20140122)
Date: Thu, 23 Jan 2014 08:23:37 +0200
Message-ID: <52E0B569.8000809@ti.com>
References: <52e06652.c103450a.79d7.6517@mx.google.com> <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57616 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbaAWGXo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jan 2014 01:23:44 -0500
In-Reply-To: <CAGa+x86=gKh11g1pzLqxdimeCxuZ478+ZAxd9GjO-m7Aa8L2fg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>

On 01/23/2014 03:35 AM, Kevin Hilman wrote:
> On Wed, Jan 22, 2014 at 4:46 PM, Kevin's boot bot <khilman@linaro.org> wrote:
>> Automated DT boot report for various ARM defconfigs.
>>
>>
>> Tree/Branch: next
>> Git describe: next-20140122
>> Failed boot tests (console logs at the end)
>> ===========================================
>>          omap3-tobi,3730storm:     FAIL:    omap2plus_defconfig
> [...]
>>          omap3-tobi,3730storm:     FAIL:    multi_v7_defconfig
>
> These OMAP3 failures are new regressions.  Full failure boot log attached.
> Bisected down to:
>
> cfa9667d4ac9da8b3ba2269f934ecd69ae504d39 is the first bad commit
> commit cfa9667d4ac9da8b3ba2269f934ecd69ae504d39
> Author: Tero Kristo <t-kristo@ti.com>
> Date:   Tue Oct 22 11:53:02 2013 +0300
>
>      ARM: OMAP2+: io: use new clock init API
>
>      clk_init is now separated to a common function which gets called for all
>      SoC:s, which initializes the DT clocks and calls the SoC specific
> clock init.
>
>      Signed-off-by: Tero Kristo <t-kristo@ti.com>
>      Acked-by: Tony Lindgren <tony@atomide.com>
>      Signed-off-by: Mike Turquette <mturquette@linaro.org>
>
> Kevin
>

Hi,

I think this is because the tobi board is including wrong omap3-soc.dtsi 
file (omap34xx.dtsi) through omap3-overo.dtsi.

The board should include omap36xx.dtsi at least based on the boot log:

[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )

-Tero
