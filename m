From: Maciej Purski <m.purski@samsung.com>
Subject: Re: Regression in Linux next again
Date: Mon, 04 Jun 2018 15:59:17 +0200
Message-ID: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
        <CGME20180604135952eucas1p292f7bcec405e6a1a6261031df36cad32@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180530144505.GB5705@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski <m.purski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,

this patchset contains previous two reverted patches. They were split
in order to make it easier to bisect, where the problem lies. It adds
also some simple debugs, which should help us track down the problem.

Tony, please apply this patchset and test it on your Beaglebone. It'd be
great if you could try to find out, which patch causes failure. They should
be appliable on the current next.

Thanks,

Maciej Purski

Maciej Purski (7):
  regulator: core: Add debug messages
  regulator: core: Add regulator_set_voltage_rdev()
  regulator: core: Use re-entrant locks
  regulator: core: Implement voltage balancing algorithm
  regulator: core: Lock dependent regulators
  regulator: core: Lock dependent regulators on regulator_enable()
  regulator: core: Enable voltage balancing

 drivers/regulator/core.c | 341 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 300 insertions(+), 41 deletions(-)

-- 
2.7.4
