From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v6 2/4] mfd: lp873x: Add lp873x PMIC support
Date: Mon, 8 Aug 2016 12:19:23 +0530
Message-ID: <57A82B73.6070005@ti.com>
References: <201608081419.tHdP36PF%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201608081419.tHdP36PF%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>, Keerthy <j-keerthy@ti.com>
Cc: kbuild-all@01.org, broonie@kernel.org, lee.jones@linaro.org, tony@atomide.com, linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org



On Monday 08 August 2016 11:56 AM, kbuild test robot wrote:
> Hi Keerthy,
>
> [auto build test ERROR on gpio/for-next]
> [also build test ERROR on v4.8-rc1 next-20160805]
> [cannot apply to ljones-mfd/for-mfd-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Keerthy/mfd-lp873x-Add-lp873x-PMIC-support/20160808-135204
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>>> drivers/mfd/lp873x.c:83:2: error: unknown field 'probe_new' specified in initializer
>       .probe_new  = lp873x_probe,
>       ^
>>> drivers/mfd/lp873x.c:83:16: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>       .probe_new  = lp873x_probe,
>                     ^~~~~~~~~~~~
>     drivers/mfd/lp873x.c:83:16: note: (near initialization for 'lp873x_driver.id_table')
>     cc1: some warnings being treated as errors
>
> vim +/probe_new +83 drivers/mfd/lp873x.c
>
>      77	
>      78	static struct i2c_driver lp873x_driver = {
>      79		.driver		= {
>      80			.name	= "lp873x",
>      81			.of_match_table = of_lp873x_match_table,
>      82		},
>    > 83		.probe_new		= lp873x_probe,

Depends on: Rebased on top of 
http://www.gossamer-threads.com/lists/linux/kernel/2457552

As mentioned clearly.

>      84	};
>      85	module_i2c_driver(lp873x_driver);
>      86	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
