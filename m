Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55835AC21;
	Wed,  1 Apr 2026 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011068; cv=none; b=NlY3zdfkXdZJlmuhmG6NpojgGPI7N3P01rQzNucR30cihqvaGhCkWMSGpJZy1bmdi7SdvEgi//apc9HqCzL1NhBys1szO6AeoWNlM8HB4+Xv5LuPDg9hJDFK9jdHauvD6zpba7p+W0DVo/QLNN8dDVJ7n2HHhD6Q8J+J2xrm6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011068; c=relaxed/simple;
	bh=Lr/nZVsMwCs7FJW1IL9UhRwXUSALhSHvdBiikIYbz2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCYIQ1luxYYZ/7boACYm6II9sfK+M3THgt3I+oeHJ4Gb6joJK6nQT5GQIlMVO6ZjjMvaHB5+yXITPM8haYvRWSZV6ZK7gLHg697YFWvKIRa3fNdQ5Hv0Gs/7gzAFGhcigukDqTWVTIeWdRKe7ajxrdvDWugtgf5qB22D4/PgrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5BcO58+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5BcO58+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775011052; x=1806547052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lr/nZVsMwCs7FJW1IL9UhRwXUSALhSHvdBiikIYbz2w=;
  b=J5BcO58+APt41qkjKKWFv12yqRqAnFCkcEOJGVFgBswbnBDBMmD+P/va
   a8y95kk8bOVRekv85XpcMxZrszaLBUu1zC+34c1089e58O8WRwmD3zGFU
   6hQteAa7og9JPJSceE2lIoPOzDfXxeNHouqe/1Yi8XSe8Z9/FW/blGE/j
   2DGYX9y+MDYou2M+kgo6aWcs2t4fyablY727AIeuIowtVisQ/6giZ7cxz
   knV+FwgqmSVh7Hvihul6x+FZR4Ozb7/QAv7sPrt5qADNKedvxY9AS6+YX
   +uIKhqnD8bMbP13OmGdOz9DsaOj2whaeWtyWHhsYCCV2VUmfqXA7xVNAZ
   A==;
X-CSE-ConnectionGUID: Hq+/sX43QkyYK7wyzEGIEQ==
X-CSE-MsgGUID: 1AdLAISiS5K95XLveqHWnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86736603"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="86736603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 19:37:31 -0700
X-CSE-ConnectionGUID: f5eHXxR4SyeRJAF2WCBADQ==
X-CSE-MsgGUID: 97F51jYeR9ukKx/EcjiTlA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 31 Mar 2026 19:37:27 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7lSP-000000004eM-046F;
	Wed, 01 Apr 2026 02:37:25 +0000
Date: Wed, 1 Apr 2026 10:37:07 +0800
From: kernel test robot <lkp@intel.com>
To: Wenyuan Li <2063309626@qq.com>, Lee Jones <lee@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn, Wenyuan Li <2063309626@qq.com>
Subject: Re: [PATCH v2] mfd: tps65910: add error handling for dummy I2C
 transfer in probe
Message-ID: <202604011034.5GOHWfcw-lkp@intel.com>
References: <tencent_74C5C53384C579056ED161B70122D16ACF06@qq.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_74C5C53384C579056ED161B70122D16ACF06@qq.com>

Hi Wenyuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes linus/master v7.0-rc6 next-20260330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenyuan-Li/mfd-tps65910-add-error-handling-for-dummy-I2C-transfer-in-probe/20260331-203820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/tencent_74C5C53384C579056ED161B70122D16ACF06%40qq.com
patch subject: [PATCH v2] mfd: tps65910: add error handling for dummy I2C transfer in probe
config: arm64-randconfig-r072-20260401 (https://download.01.org/0day-ci/archive/20260401/202604011034.5GOHWfcw-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 2cd67b8b69f78e3f95918204320c3075a74ba16c)
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604011034.5GOHWfcw-lkp@intel.com/

smatch warnings:
drivers/mfd/tps65910.c:487 tps65910_i2c_probe() warn: inconsistent indenting

vim +487 drivers/mfd/tps65910.c

   439	
   440	static int tps65910_i2c_probe(struct i2c_client *i2c)
   441	{
   442		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
   443		struct tps65910 *tps65910;
   444		struct tps65910_board *pmic_plat_data;
   445		struct tps65910_board *of_pmic_plat_data = NULL;
   446		struct tps65910_platform_data *init_data;
   447		unsigned long chip_id = id->driver_data;
   448		int ret;
   449	
   450		pmic_plat_data = dev_get_platdata(&i2c->dev);
   451	
   452		if (!pmic_plat_data && i2c->dev.of_node) {
   453			pmic_plat_data = tps65910_parse_dt(i2c, &chip_id);
   454			of_pmic_plat_data = pmic_plat_data;
   455		}
   456	
   457		if (!pmic_plat_data)
   458			return -EINVAL;
   459	
   460		init_data = devm_kzalloc(&i2c->dev, sizeof(*init_data), GFP_KERNEL);
   461		if (init_data == NULL)
   462			return -ENOMEM;
   463	
   464		tps65910 = devm_kzalloc(&i2c->dev, sizeof(*tps65910), GFP_KERNEL);
   465		if (tps65910 == NULL)
   466			return -ENOMEM;
   467	
   468		tps65910->of_plat_data = of_pmic_plat_data;
   469		i2c_set_clientdata(i2c, tps65910);
   470		tps65910->dev = &i2c->dev;
   471		tps65910->i2c_client = i2c;
   472		tps65910->id = chip_id;
   473	
   474		/* Work around silicon erratum SWCZ010: the tps65910 may miss the
   475		 * first I2C transfer. So issue a dummy transfer before the first
   476		 * real transfer.
   477		 */
   478		ret = i2c_master_send(i2c, "", TPS65910_DUMMY_XFER_LEN);
   479		if (ret != TPS65910_DUMMY_XFER_LEN) {
   480			int err;
   481	
   482			if (ret < 0)
   483				err = ret;
   484			else
   485				err = -EIO;
   486	
 > 487		return dev_err_probe(&i2c->dev, err, "dummy transfer failed\n");
   488		}
   489	
   490		tps65910->regmap = devm_regmap_init_i2c(i2c, &tps65910_regmap_config);
   491		if (IS_ERR(tps65910->regmap)) {
   492			ret = PTR_ERR(tps65910->regmap);
   493			dev_err(&i2c->dev, "regmap initialization failed: %d\n", ret);
   494			return ret;
   495		}
   496	
   497		init_data->irq = pmic_plat_data->irq;
   498		init_data->irq_base = pmic_plat_data->irq_base;
   499	
   500		tps65910_irq_init(tps65910, init_data->irq, init_data);
   501		tps65910_ck32k_init(tps65910, pmic_plat_data);
   502		tps65910_sleepinit(tps65910, pmic_plat_data);
   503	
   504		if (pmic_plat_data->pm_off && !pm_power_off) {
   505			/*
   506			 * The PWR_OFF bit needs to be set separately, before
   507			 * transitioning to the OFF state. It enables the "sequential"
   508			 * power-off mode on TPS65911, it's a NO-OP on TPS65910.
   509			 */
   510			ret = regmap_set_bits(tps65910->regmap, TPS65910_DEVCTRL,
   511					      DEVCTRL_PWR_OFF_MASK);
   512			if (ret) {
   513				dev_err(&i2c->dev, "failed to set power-off mode: %d\n",
   514					ret);
   515				return ret;
   516			}
   517	
   518			tps65910_i2c_client = i2c;
   519			pm_power_off = tps65910_power_off;
   520		}
   521	
   522		ret = devm_mfd_add_devices(tps65910->dev, -1,
   523					   tps65910s, ARRAY_SIZE(tps65910s),
   524					   NULL, 0,
   525					   regmap_irq_get_domain(tps65910->irq_data));
   526		if (ret < 0) {
   527			dev_err(&i2c->dev, "mfd_add_devices failed: %d\n", ret);
   528			return ret;
   529		}
   530	
   531		return ret;
   532	}
   533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
