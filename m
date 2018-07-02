From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
Date: Mon, 2 Jul 2018 01:05:05 -0700
Message-ID: <20180702080505.GN112168@atomide.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529330913-11152-1-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

* Maciej Purski <m.purski@samsung.com> [180618 14:11]:
> If the regulator is not coupled, balance_voltage() should preserve
> its desired max uV, instead of setting the exact value like in
> coupled regulators case.
> 
> Remove debugs, which are not necessary for now.

Sorry for the delay in testing. I gave your series with this one
a quick boot test on beagleboard-x15 and now the output is
different. So instead of just hanging it seems to be stuck in
some eternal loop see below.

Regards,

Tony

8< -------
 * Loading modules ...[   14.490595] omap-mailbox 48840000.mailbox: omap mailbox rev 0x400
[   14.498515] omap-mailbox 48842000.mailbox: omap mailbox rev 0x400
[   14.535853] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[   14.937029] lib80211: common routines for IEEE802.11 drivers
[   15.350565] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   15.448875] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   15.460831] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.469916] cfg80211: failed to load regulatory.db
[   16.092151] cpu cpu0: regulator_set_voltage: 3387
[   16.097313] smps12: regulator_set_voltage_unlocked:  3040
[   16.109880] smps12: optimal uV: 1154000 current uV: 970000, max uV: 1250000
[   16.117085] smps12: regulator_set_voltage_rdev: 3110
[   16.122696] smps12: _regulator_do_set_voltage: 2907
[   16.130443] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.137824] smps12: regulator_set_voltage_rdev: 3110
[   16.143334] smps12: _regulator_do_set_voltage: 2907
[   16.149849] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.157174] smps12: regulator_set_voltage_rdev: 3110
[   16.162683] smps12: _regulator_do_set_voltage: 2907
[   16.169069] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.176391] smps12: regulator_set_voltage_rdev: 3110
[   16.181932] smps12: _regulator_do_set_voltage: 2907
[   16.188353] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.195614] smps12: regulator_set_voltage_rdev: 3110
[   16.201199] smps12: _regulator_do_set_voltage: 2907
[   16.207676] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.214931] smps12: regulator_set_voltage_rdev: 3110
[   16.220614] smps12: _regulator_do_set_voltage: 2907
[   16.227159] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.234379] smps12: regulator_set_voltage_rdev: 3110
[   16.239961] smps12: _regulator_do_set_voltage: 2907
[   16.246494] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.253746] smps12: regulator_set_voltage_rdev: 3110
[   16.259890] smps12: _regulator_do_set_voltage: 2907
[   16.267013] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.274114] smps12: regulator_set_voltage_rdev: 3110
[   16.279565] smps12: _regulator_do_set_voltage: 2907
[   16.288426] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.295562] smps12: regulator_set_voltage_rdev: 3110
[   16.301580] smps12: _regulator_do_set_voltage: 2907
[   16.308331] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.315655] smps12: regulator_set_voltage_rdev: 3110
[   16.321328] smps12: _regulator_do_set_voltage: 2907
[   16.327686] smps12: optimal uV: 1154000 current uV: 1160000, max uV: 1250000
[   16.334945] smps12: regulator_set_voltage_rdev: 3110
[   16.340662] smps12: _regulator_do_set_voltage: 2907
