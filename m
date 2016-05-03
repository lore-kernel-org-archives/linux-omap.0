From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] HSI: omap_ssi: built omap_ssi and omap_ssi_port into
 one module
Date: Tue, 3 May 2016 10:32:39 -0700
Message-ID: <20160503173239.GO5995@atomide.com>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
 <1461982153-19139-6-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461982153-19139-6-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160429 19:11]:
> Merge omap_ssi and omap_ssi_port into one module. This
> fixes problems with module cycle dependencies introduced
> by future patches.

Can you please check against the hardware for the split?
For reference, below is what I dumped out from dm3730 for
the modules on the L4 interconnect:

0x48000000 + 0x40000 + 0x18000 = 0x48058000, size 0x1000, parent with sysc
 0x48000000 + 0x40000 + 0x19000 = 0x48059000, size 0x1000, gdd
 0x48000000 + 0x40000 + 0x1a000 = 0x4805a000, size 0x1000, ssi_port1
 0x48000000 + 0x40000 + 0x1b000 = 0x4805b000, size 0x1000, ssi_port2

0x48000000 + 0x40000 + 0x1c000 = 0x4805c000, size 0x1000, target agent

So the parent target module at 0x48058000 controls everything
with the sysc register. The gdd, ssi_port1 and ssi_port2 are
children of the parent target module at 0x48058000 and should
not have any sysc related registers.

Can you please check if gdd, ssi_port1 and ssi_port2 have any
sysc related registers too? :) If they do, then they too can
idle on their own but most likely still depend on the parent
module.

The target agent above is a separate module with the
interconnect related registers, no need to do anything with
that AFAIK.

I believe this is the same for 34xx too but have not dumped it
out of the hardware. I can do that if the above does not match
what you're seeing.

If we want to have separate driver modules, you can do this:

1. Have the parent target module at 0x4805800 do PM runtime
   calls, they then propagate to the hwmod code properly for
   the ti,hwmods = "ssi" entry. This module can be minimal,
   and can also have child devices within it's first 0x1000
   sized range if needed.

2. Have the parent target module probe the child device
   drivers as needed with of_platform_populate() at the end
   of it's probe. The children can't be pm_runtime_irq_safe
   as it permanently blocks the idling of the parent.

3. Have the the parent target module at 0x4805800 implement
   PM runtime for it's children by registering
   struct dev_pm_ops for them.

If you really want to have them all as a single module then
that should work too as long as there's only one set of sysc
related registers.

Regards,

Tony
