From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH] reset: Introduce static inline dummy function when CONFIG_RESET_CONTROLLER
Date: Tue, 01 Dec 2015 10:07:45 -0600
Message-ID: <565DC5D1.2080809@gmail.com>
References: <201512012339.srrujPao%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201512012339.srrujPao%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>, Nishanth Menon <nm@ti.com>
Cc: linux-kernel@vger.kernel.org, kbuild-all@01.org, Philipp Zabel <p.zabel@pengutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/01/2015 09:56 AM, kbuild test robot wrote:
> Hi Nishanth,
> 
> [auto build test ERROR on v4.4-rc3]
> [also build test ERROR on next-20151127]
> 
> url:    https://github.com/0day-ci/linux/commits/Nishanth-Menon/reset-Introduce-static-inline-dummy-function-when-CONFIG_RESET_CONTROLLER/20151201-233708
> config: i386-randconfig-n0-201548 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/reset/core.c:18:0:
>>> include/linux/reset-controller.h:1:0: error: unterminated #ifndef
>     #ifndef _LINUX_RESET_CONTROLLER_H_
>     ^

Uggh.. thanks kbot... :).. my bad.. last minute whitespace editscan end
up deleting #endifs  :(

While at it, will fix $subject as well.

-- 
Regards,
Nishanth Menon
