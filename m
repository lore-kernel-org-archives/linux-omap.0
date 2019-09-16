From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 6/8] ARM: dts: omap36xx: using OPP1G needs to control
 the abb_ldo
Date: Mon, 16 Sep 2019 09:25:53 -0700
Message-ID: <20190916162553.GC52127@atomide.com>
References: <cover.1568224032.git.hns@goldelico.com>
 <59a0f6267c75859c25665548db2e8a9c4229d3b4.1568224033.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59a0f6267c75859c25665548db2e8a9c4229d3b4.1568224033.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
> See DM3730,DM275 data sheet (SPRS685B) footnote (6) in Table 4-19
> which says that ABB must be switched to FBB mode when using the
> OPP1G.
> 
> The LOD definition abb_mpu_iva already exists so that we need
> to add plumbing for vbb-supply = <&abb_mpu_iva>
> and define two voltage vectors for each OPP so that the abb LDO
> is also updated by the ti-cpufreq driver.
> 
> We also must switch the ti_cpufreq_soc_data to multi_regulator.
> 
> Note: reading out the abb reglator voltage to verify that
> it does do transitions can be done by
> 
> cat /sys/devices/platform/68000000.ocp/483072f0.regulator-abb-mpu/regulator/regulator.*/microvolts
> 
> Likewise, read the twl4030 provided VDD voltage by
> 
> cat /sys/devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl@48:regulator-vdd1/regulator/regulator.*/microvolts
> 
> Note: to check if the ABB FBB is enabled/disabled, check
> registers
> 
> PRM_LDO_ABB_CTRL 0x483072F4 bit 3:0 1=bypass 5=FBB
> PRM_LDO_ABB_SETUP 0x483072F0 0x00=bypass 0x11=FBB
> 
> e.g.
> 
> /dev/mem opened.
> Memory mapped at address 0xb6fe4000.
> Value at address 0x483072F4 (0xb6fe42f4): 0x3205
> /dev/mem opened.
> Memory mapped at address 0xb6f89000.
> Value at address 0x483072F4 (0xb6f892f4): 0x3201
> 
> Note: omap34xx and am3517 have/need no comparable LDO
> or mechanism.

Acked-by: Tony Lindgren <tony@atomide.com>
