From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] regulator: tps65917/palmas: Cleanups and bugfixes
Date: Thu, 5 May 2016 19:29:48 -0500
Message-ID: <1462494592-27909-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

While attempting to try and get each of the regulator nodes of palmas
to be capable of using vin-supply, I noticed a few cleanups and
associated bug fixes.

The series is based on next-20160504 and is split up to aid
readability of the patch.

Tested on OMAP5-uevm and DRA7 platform.

Nishanth Menon (4):
  regulator: tps65917/palmas: Simplify multiple dereference of
    ddata->palmas_matches[idx]
  regulator: tps65917/palmas: Simplify multiple dereference of
    pdata->reg_init[idx]
  regulator: tps65917/palmas: Handle possible memory allocation failure
  regulator: tps65917/palmas: Simplify multiple dereference of
    match->of_node

 drivers/regulator/palmas-regulator.c | 62 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 29 deletions(-)

-- 
2.8.0
