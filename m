From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 11/17] soc: ti: pruss: add pruss_get()/put() API
Date: Fri, 23 Nov 2018 11:41:58 +0200
Message-ID: <5BF7CB66.5010506@ti.com>
References: <1542886753-17625-12-git-send-email-rogerq@ti.com>
 <201811231005.TMHd9O2k%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201811231005.TMHd9O2k%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 23/11/18 04:47, kbuild test robot wrote:
> Hi Tero,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on keystone/next]
> [also build test ERROR on v4.20-rc3 next-20181122]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Roger-Quadros/Add-support-for-TI-PRU-ICSS/20181123-083903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from drivers/soc/ti/pruss_intc.c:16:0:
>>> include/linux/pruss.h:39:32: warning: 'struct rproc' declared inside parameter list will not be visible outside of this definition or declaration
>     struct pruss *pruss_get(struct rproc *rproc);
>                                    ^~~~~

This was my bad due to re-ordering of patches. Fixed now.

cheers,
-roger

> --
>    In file included from drivers/soc/ti/pruss.c:15:0:
>>> include/linux/pruss.h:39:32: warning: 'struct rproc' declared inside parameter list will not be visible outside of this definition or declaration
>     struct pruss *pruss_get(struct rproc *rproc);
>                                    ^~~~~
>>> drivers/soc/ti/pruss.c:34:15: error: conflicting types for 'pruss_get'
>     struct pruss *pruss_get(struct rproc *rproc)
>                   ^~~~~~~~~
>    In file included from drivers/soc/ti/pruss.c:15:0:
>    include/linux/pruss.h:39:15: note: previous declaration of 'pruss_get' was here
>     struct pruss *pruss_get(struct rproc *rproc);
>                   ^~~~~~~~~
>    In file included from include/linux/linkage.h:7:0,
>                     from include/linux/kernel.h:7,
>                     from include/linux/list.h:9,
>                     from include/linux/kobject.h:19,
>                     from include/linux/device.h:16,
>                     from include/linux/dma-mapping.h:7,
>                     from drivers/soc/ti/pruss.c:10:
>    drivers/soc/ti/pruss.c:58:19: error: conflicting types for 'pruss_get'
>     EXPORT_SYMBOL_GPL(pruss_get);
>                       ^
>    include/linux/export.h:79:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^~~
>>> drivers/soc/ti/pruss.c:58:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
>     EXPORT_SYMBOL_GPL(pruss_get);
>     ^~~~~~~~~~~~~~~~~
>    In file included from drivers/soc/ti/pruss.c:15:0:
>    include/linux/pruss.h:39:15: note: previous declaration of 'pruss_get' was here
>     struct pruss *pruss_get(struct rproc *rproc);
>                   ^~~~~~~~~
> --
>    In file included from drivers/soc//ti/pruss.c:15:0:
>>> include/linux/pruss.h:39:32: warning: 'struct rproc' declared inside parameter list will not be visible outside of this definition or declaration
>     struct pruss *pruss_get(struct rproc *rproc);
>                                    ^~~~~
>    drivers/soc//ti/pruss.c:34:15: error: conflicting types for 'pruss_get'
>     struct pruss *pruss_get(struct rproc *rproc)
>                   ^~~~~~~~~
>    In file included from drivers/soc//ti/pruss.c:15:0:
>    include/linux/pruss.h:39:15: note: previous declaration of 'pruss_get' was here
>     struct pruss *pruss_get(struct rproc *rproc);
>                   ^~~~~~~~~
>    In file included from include/linux/linkage.h:7:0,
>                     from include/linux/kernel.h:7,
>                     from include/linux/list.h:9,
>                     from include/linux/kobject.h:19,
>                     from include/linux/device.h:16,
>                     from include/linux/dma-mapping.h:7,
>                     from drivers/soc//ti/pruss.c:10:
>    drivers/soc//ti/pruss.c:58:19: error: conflicting types for 'pruss_get'
>     EXPORT_SYMBOL_GPL(pruss_get);
>                       ^
>    include/linux/export.h:79:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^~~
>    drivers/soc//ti/pruss.c:58:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
>     EXPORT_SYMBOL_GPL(pruss_get);
>     ^~~~~~~~~~~~~~~~~
>    In file included from drivers/soc//ti/pruss.c:15:0:
>    include/linux/pruss.h:39:15: note: previous declaration of 'pruss_get' was here
>     struct pruss *pruss_get(struct rproc *rproc);
>                   ^~~~~~~~~
> 
> vim +/pruss_get +34 drivers/soc/ti/pruss.c
> 
>   > 10	#include <linux/dma-mapping.h>
>     11	#include <linux/module.h>
>     12	#include <linux/io.h>
>     13	#include <linux/of_address.h>
>     14	#include <linux/of_device.h>
>   > 15	#include <linux/pruss.h>
>     16	#include <linux/remoteproc.h>
>     17	
>     18	#include "pruss.h"
>     19	
>     20	/**
>     21	 * pruss_get() - get the pruss for a given PRU remoteproc
>     22	 * @rproc: remoteproc handle of a PRU instance
>     23	 *
>     24	 * Finds the parent pruss device for a PRU given the @rproc handle of the
>     25	 * PRU remote processor. This function increments the pruss device's refcount,
>     26	 * so always use pruss_put() to decrement it back once pruss isn't needed
>     27	 * anymore.
>     28	 *
>     29	 * Returns the pruss handle on success, and an ERR_PTR on failure using one
>     30	 * of the following error values
>     31	 *    -EINVAL if invalid parameter
>     32	 *    -ENODEV if PRU device or PRUSS device is not found
>     33	 */
>   > 34	struct pruss *pruss_get(struct rproc *rproc)
>     35	{
>     36		struct pruss *pruss;
>     37		struct device *dev;
>     38		struct platform_device *ppdev;
>     39	
>     40		if (IS_ERR_OR_NULL(rproc))
>     41			return ERR_PTR(-EINVAL);
>     42	
>     43		dev = &rproc->dev;
>     44		if (!dev->parent)
>     45			return ERR_PTR(-ENODEV);
>     46	
>     47		/* rudimentary check to make sure rproc handle is for a PRU */
>     48		if (!strstr(dev_name(dev->parent), "pru"))
>     49			return ERR_PTR(-ENODEV);
>     50	
>     51		ppdev = to_platform_device(dev->parent->parent);
>     52		pruss = platform_get_drvdata(ppdev);
>     53		if (pruss)
>     54			get_device(pruss->dev);
>     55	
>     56		return pruss ? pruss : ERR_PTR(-ENODEV);
>     57	}
>   > 58	EXPORT_SYMBOL_GPL(pruss_get);
>     59	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
