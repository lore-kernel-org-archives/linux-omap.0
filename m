From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 12/12] mtd: nand: move of_get_nand_xxx() helpers into
 nand_base.c
Date: Fri, 1 Apr 2016 22:13:43 +0800
Message-ID: <201604012200.EksFk1z5%fengguang.wu@intel.com>
References: <1459515272-31011-13-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459515272-31011-13-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Han Xu <han.xu@nxp.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Agner <stefan@agner.ch>, linux-omap@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesse>
List-Id: linux-omap@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Boris,

[auto build test WARNING on next-20160401]
[cannot apply to v4.6-rc1 v4.5-rc7 v4.5-rc6 v4.6-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-get-rid-of-of_mtd-c-h-and-of_get_nand_xx/20160401-210220
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/nand_base.c:3972: warning: cannot understand function prototype: 'const char * const nand_ecc_modes[] = '
   drivers/mtd/nand/nand_bbt.c:1: warning: no structured comments found
>> drivers/mtd/nand/nand_base.c:3972: warning: cannot understand function prototype: 'const char * const nand_ecc_modes[] = '

vim +3972 drivers/mtd/nand/nand_base.c

  3956					chip->jedec_params.model);
  3957		else
  3958			pr_info("%s %s\n", nand_manuf_ids[maf_idx].name,
  3959					type->name);
  3960	
  3961		pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size: %d\n",
  3962			(int)(chip->chipsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
  3963			mtd->erasesize >> 10, mtd->writesize, mtd->oobsize);
  3964		return type;
  3965	}
  3966	
  3967	/**
  3968	 * It maps 'enum nand_ecc_modes_t' found in include/linux/mtd/nand.h
  3969	 * into the device tree binding of 'nand-ecc', so that MTD
  3970	 * device driver can get nand ecc from device tree.
  3971	 */
> 3972	static const char * const nand_ecc_modes[] = {
  3973		[NAND_ECC_NONE]		= "none",
  3974		[NAND_ECC_SOFT]		= "soft",
  3975		[NAND_ECC_HW]		= "hw",
  3976		[NAND_ECC_HW_SYNDROME]	= "hw_syndrome",
  3977		[NAND_ECC_HW_OOB_FIRST]	= "hw_oob_first",
  3978		[NAND_ECC_SOFT_BCH]	= "soft_bch",
  3979	};
  3980	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--T4sUOijqQbZv57TR
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--T4sUOijqQbZv57TR--
