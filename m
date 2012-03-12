From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for v3.4
Date: Mon, 12 Mar 2012 10:26:53 -0700
Message-ID: <87399dzq5e.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
	<87399jc6cj.fsf@ti.com> <20120309003217.GB12083@atomide.com>
	<20120309114731.GA3273@opensource.wolfsonmicro.com>
	<87zkbp4wtj.fsf@ti.com>
	<20120311204232.GC3171@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35208 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753309Ab2CLR0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 13:26:46 -0400
Received: by mail-iy0-f177.google.com with SMTP id y10so9836626iak.22
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 10:26:45 -0700 (PDT)
In-Reply-To: <20120311204232.GC3171@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Sun, 11 Mar 2012 20:42:33 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> The branch itself is essentially stable but I'm not enthused about the
> idea of merging the whole thing via the OMAP tree.  

Right, I wasn't suggesting we merge it via OMAP tree.   I was just
looking for a stable point we could use as s dependency when merging
everything together for the arm-soc tree.

> However, as Linus has released an -rc7 I should pull some stuff out of
> there and send fixes to him so I've created a topic/twl so let's just
> rebase.

OK.

>> > In general you should warn people if you've got a dependency on their
>> > tree, it makes life easier.
>
>> Yeah, I should've raised this when the original series were posted.  The
>> arch stuff and drivers/regulator stuff were posted all together, but you
>> picked out the regulator stuff and I picked up the rest.  
>
> Actually IIRC by the time I applied this the ARM changes had been
> totally deteched from the regulator stuff - Tero was sending just the
> regulator patch by itself and I actually applied the patch it was part
> of a twl regulator series Rajendra put together after I got fed up with
> the number of people sending me incompatible changes without talking to
> each other.  I'd completely forgotten about any arch/arm stuff.
>
> This sort of issue is becoming far too common with the OMAP stuff, there
> needs to be a much greater awareness of the need to coordinate both
> between trees and with multiple people working on the same code.

Completely agree, hence this email trying to work this out before the
merge window.

Thanks for this topic branch.  We'll ask for it to be included as a
branch in arm-soc/depends/* so that OMAP voltage core changes will build
there as well as in linux-next.

Thanks,

Kevin


> The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
>
>   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/twl
>
> for you to fetch changes up to 46eda3e96a65b378041c79c51ff2e02009f7e2d0:
>
>   mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS (2012-03-11 20:09:26 +0000)
>
> ----------------------------------------------------------------
> TWL specific changes, cross-merged with OMAP due to arch/arm wanting to
> use the new ability to override the voltage set and get operations to
> support the in-CPU voltage management.  The other changes are minor
> fixes, the addition of a few new regulators and device tree support.
>
> ----------------------------------------------------------------
> Laxman Dewangan (1):
>       regulator: twl6030: Fix voltage selection logic
>
> Peter Ujfalusi (2):
>       regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
>       mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS
>
> Rajendra Nayak (1):
>       regulator: twl: adapt twl-regulator driver to dt
>
> Tero Kristo (2):
>       regulator: twl4030: add support for external voltage get/set
>       regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators
>
>  .../bindings/regulator/twl-regulator.txt           |   68 ++++
>  drivers/mfd/twl-core.c                             |   41 +++-
>  drivers/regulator/twl-regulator.c                  |  327 +++++++++++++++-----
>  include/linux/i2c/twl.h                            |   14 +-
>  4 files changed, 366 insertions(+), 84 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/twl-regulator.txt
