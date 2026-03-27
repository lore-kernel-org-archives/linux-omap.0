Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4F39901C
	for <linux-omap@vger.kernel.org>; Fri, 27 Mar 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600275; cv=none; b=mCN3HtehYZgh1TNel2eZ5SmwRJkEc9p3wrVSzXAYvyGPWnf1DoAs0WQb02hyyuBOOjnpA1iyyFtberOpnuVdu7xonHbLN78wCpAxJVvi3qVxi8PkZ53CDgsH7Il9MVCOG2+/qlMSC8gZ2e06R/8894jgnD99y/uK4UMc+AQFDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600275; c=relaxed/simple;
	bh=cwCm2+Q+66l8Xg6RKcUkjedaz/COn6+KVSouDqdf1w0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI0rQkbEy9Do+WqjNSepOHsFLNWeUy3KxkteEq4dAIaBQS1BICvVAIN4kwEIhC9iI47X6XtF8WoTJ9Idl9zckX4AQFzlSgQLNeRHrkF2trPblI0DYyBbvk99BVRKNmKs4nzCq6y2nOLkNUYFfPcV9SvWHZXnFWUsB3qVWFVf/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgKiWOv5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgKiWOv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774600274; x=1806136274;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=cwCm2+Q+66l8Xg6RKcUkjedaz/COn6+KVSouDqdf1w0=;
  b=LgKiWOv5XreJP2yI+jZEEW4V/sm9OS8scYKEA8pUsPSKWDzHfXmd4AhA
   eYv6CyfkVUu/A+J594du3uurb8xdulRyke56xnW60WNAaofxSo7WJ2IL2
   K/tmxGke7KXzQGEvFLxFKDDP5jkWtJatDAvIfbHBIhxSPloZehfEQodVn
   K0TNE0n5X6mEwsK5KjHGc2mcViiJUhWVxQW5DVd35dJ2St9abrG/Wvif8
   7FuK/xz6ieeAf1shzzLsdJMM0IHCFQ7ojNMzEprNmgujvWHxnhDYzZNO6
   jJejeuZyGCuyQH6Q8S9ljPZ2jLDifqq1y2DqJjlQDDunLy0HXphK6UuPI
   w==;
X-CSE-ConnectionGUID: seJwzO19RZ6YA+cpurdJRA==
X-CSE-MsgGUID: Sqewdq/NTh6OSw7Bwo/rQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="63225371"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="63225371"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:31:13 -0700
X-CSE-ConnectionGUID: QIoJEFvUSMKhoZ3its6Eww==
X-CSE-MsgGUID: JhjKJ3GZQEi8TiyEDWkJsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255751626"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 01:31:12 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w62az-000000009yT-2yvy;
	Fri, 27 Mar 2026 08:31:09 +0000
Date: Fri, 27 Mar 2026 16:30:57 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: simplify allocation for omap_device
Message-ID: <202603271603.kDc2a9Vh-lkp@intel.com>
References: <20260326023432.54127-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326023432.54127-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.0-rc5]
[also build test WARNING on linus/master next-20260326]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/ARM-omap2-simplify-allocation-for-omap_device/20260327-022104
base:   v7.0-rc5
patch link:    https://lore.kernel.org/r/20260326023432.54127-1-rosenp%40gmail.com
patch subject: [PATCH] ARM: omap2: simplify allocation for omap_device
config: arm-randconfig-003-20260327 (https://download.01.org/0day-ci/archive/20260327/202603271603.kDc2a9Vh-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271603.kDc2a9Vh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271603.kDc2a9Vh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap2/omap_device.c:325:3: warning: variable 'hwmods' is uninitialized when used here [-Wuninitialized]
     325 |                 hwmods[i]->od = od;
         |                 ^~~~~~
   arch/arm/mach-omap2/omap_device.c:310:28: note: initialize the variable 'hwmods' to silence this warning
     310 |         struct omap_hwmod **hwmods;
         |                                   ^
         |                                    = NULL
   1 warning generated.


vim +/hwmods +325 arch/arm/mach-omap2/omap_device.c

b04b65ab5b4fc8 arch/arm/plat-omap/omap_device.c  Paul Walmsley         2009-09-03  292  
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  293  /**
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  294   * omap_device_alloc - allocate an omap_device
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  295   * @pdev: platform_device that will be included in this omap_device
7b6560b4bc623d arch/arm/mach-omap2/omap_device.c Ben Dooks (Codethink  2019-11-06  296)  * @ohs: ptr to the omap_hwmod for this omap_device
7b6560b4bc623d arch/arm/mach-omap2/omap_device.c Ben Dooks (Codethink  2019-11-06  297)  * @oh_cnt: the size of the ohs list
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  298   *
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  299   * Convenience function for allocating an omap_device structure and filling
c1d1cd597fc77a arch/arm/mach-omap2/omap_device.c Paul Walmsley         2013-01-26  300   * hwmods, and resources.
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  301   *
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  302   * Returns an struct omap_device pointer or ERR_PTR() on error;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  303   */
6aeb51c1035c1c arch/arm/mach-omap2/omap_device.c Arnd Bergmann         2022-09-28  304  static struct omap_device *omap_device_alloc(struct platform_device *pdev,
c1d1cd597fc77a arch/arm/mach-omap2/omap_device.c Paul Walmsley         2013-01-26  305  					struct omap_hwmod **ohs, int oh_cnt)
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  306  {
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  307  	int ret = -ENOMEM;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  308  	struct omap_device *od;
c2b84a9bb3414c arch/arm/mach-omap2/omap_device.c Tony Lindgren         2017-10-10  309  	int i;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  310  	struct omap_hwmod **hwmods;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  311  
d2740219a804bc arch/arm/mach-omap2/omap_device.c Rosen Penev           2026-03-25  312  	od = kzalloc_flex(*od, hwmods, oh_cnt);
d2740219a804bc arch/arm/mach-omap2/omap_device.c Rosen Penev           2026-03-25  313  	if (!od) {
d2740219a804bc arch/arm/mach-omap2/omap_device.c Rosen Penev           2026-03-25  314  		dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
d2740219a804bc arch/arm/mach-omap2/omap_device.c Rosen Penev           2026-03-25  315  		return ERR_PTR(ret);
d2740219a804bc arch/arm/mach-omap2/omap_device.c Rosen Penev           2026-03-25  316  	}
6d9be9376b0e29 arch/arm/mach-omap2/omap_device.c Jing Xiangfeng        2020-09-19  317  
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  318  	od->hwmods_cnt = oh_cnt;
d2740219a804bc arch/arm/mach-omap2/omap_device.c Rosen Penev           2026-03-25  319  	memcpy(od->hwmods, ohs, oh_cnt * sizeof(*od->hwmods));
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  320  
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  321  	od->pdev = pdev;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  322  	pdev->archdata.od = od;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  323  
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  324  	for (i = 0; i < oh_cnt; i++) {
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09 @325  		hwmods[i]->od = od;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  326  		_add_hwmod_clocks_clkdev(od, hwmods[i]);
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  327  	}
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  328  
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  329  	return od;
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  330  }
a4f6cdb0672fe9 arch/arm/plat-omap/omap_device.c  Benoit Cousson        2011-08-09  331  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
