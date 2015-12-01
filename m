From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] reset: Introduce static inline dummy function when
 CONFIG_RESET_CONTROLLER
Date: Wed, 2 Dec 2015 04:20:11 +0800
Message-ID: <201512020452.RzkhnbRw%fengguang.wu@intel.com>
References: <1448984088-31904-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448984088-31904-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

[auto build test WARNING on: v4.4-rc3]
[also build test WARNING on: next-20151127]

url:    https://github.com/0day-ci/linux/commits/Nishanth-Menon/reset-Introduce-static-inline-dummy-function-when-CONFIG_RESET_CONTROLLER/20151201-233708
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> include/linux/reset-controller.h:1:2: sparse: unterminated preprocessor conditional
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
   In file included from drivers/reset/core.c:18:0:
   include/linux/reset-controller.h:1:0: error: unterminated #ifndef
    #ifndef _LINUX_RESET_CONTROLLER_H_
    ^
--
>> include/linux/reset-controller.h:1:2: sparse: unterminated preprocessor conditional
>> include/linux/reset-controller.h:1:2: sparse: unterminated preprocessor conditional
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
   In file included from drivers/clk/qcom/reset.c:17:0:
   include/linux/reset-controller.h:1:0: error: unterminated #ifndef
    #ifndef _LINUX_RESET_CONTROLLER_H_
    ^
   In file included from drivers/clk/qcom/reset.h:17:0,
                    from drivers/clk/qcom/reset.c:20:
   include/linux/reset-controller.h:1:0: error: unterminated #ifndef
    #ifndef _LINUX_RESET_CONTROLLER_H_
    ^

vim +1 include/linux/reset-controller.h

61fc4131 Philipp Zabel 2012-11-19 @1  #ifndef _LINUX_RESET_CONTROLLER_H_
61fc4131 Philipp Zabel 2012-11-19  2  #define _LINUX_RESET_CONTROLLER_H_
61fc4131 Philipp Zabel 2012-11-19  3  
61fc4131 Philipp Zabel 2012-11-19  4  #include <linux/list.h>
61fc4131 Philipp Zabel 2012-11-19  5  
61fc4131 Philipp Zabel 2012-11-19  6  struct reset_controller_dev;
61fc4131 Philipp Zabel 2012-11-19  7  
61fc4131 Philipp Zabel 2012-11-19  8  /**
61fc4131 Philipp Zabel 2012-11-19  9   * struct reset_control_ops

:::::: The code at line 1 was first introduced by commit
:::::: 61fc41317666be400802ac793f47de816ef7bd57 reset: Add reset controller API

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Philipp Zabel <p.zabel@pengutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
