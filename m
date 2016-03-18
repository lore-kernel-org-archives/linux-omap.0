From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: DTS: da850/am4372/am33xx: Use generic node
 name for ehrpwm
Date: Thu, 17 Mar 2016 20:00:13 -0500
Message-ID: <56EB531D.7050406@ti.com>
References: <1458252463-8821-3-git-send-email-fcooper@ti.com>
 <201603180818.rtawXhxL%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <201603180818.rtawXhxL%fengguang.wu@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/17/2016 07:27 PM, kbuild test robot wrote:
> Hi Franklin,
>
> [auto build test ERROR on pwm/for-next]
> [also build test ERROR on v4.5 next-20160317]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Franklin-S-Cooper-Jr/clk-ti-am335x-am4372-Add-tbclk-to-pwm-node/20160318-060938
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm for-next
> config: arm-multi_v7_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
>
> All errors (new ones prefixed by >>):
>
>    ERROR (duplicate_label): Duplicate label 'ehrpwm1' on /ocp/epwmss@48302000/ehrpwm@48302200 and /ocp/epwmss@48302000/pwm@48302200

Ok I see that I missed also updating am335x-shc.dts. I'll
send a v3
>>> ERROR: Input tree has errors, aborting (use -f to force output)
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
