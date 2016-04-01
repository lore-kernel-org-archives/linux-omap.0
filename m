From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 12/12] mtd: nand: move of_get_nand_xxx()
 helpers into nand_base.c
Date: Fri, 1 Apr 2016 17:34:48 +0200
Message-ID: <20160401173448.2a9344c5@bbrezillon>
References: <1459515272-31011-13-git-send-email-boris.brezillon@free-electrons.com>
	<201604012200.EksFk1z5%fengguang.wu@intel.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBK5K7K3QKGQE3ZCW65Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <201604012200.EksFk1z5%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel
List-Id: linux-omap@vger.kernel.org

On Fri, 1 Apr 2016 22:13:43 +0800
kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> Hi Boris,
> 
> [auto build test WARNING on next-20160401]
> [cannot apply to v4.6-rc1 v4.5-rc7 v4.5-rc6 v4.6-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-get-rid-of-of_mtd-c-h-and-of_get_nand_xx/20160401-210220
> reproduce: make htmldocs
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/mtd/nand/nand_base.c:3972: warning: cannot understand function prototype: 'const char * const nand_ecc_modes[] = '
>    drivers/mtd/nand/nand_bbt.c:1: warning: no structured comments found
> >> drivers/mtd/nand/nand_base.c:3972: warning: cannot understand function prototype: 'const char * const nand_ecc_modes[] = '
> 
> vim +3972 drivers/mtd/nand/nand_base.c
> 
>   3956					chip->jedec_params.model);
>   3957		else
>   3958			pr_info("%s %s\n", nand_manuf_ids[maf_idx].name,
>   3959					type->name);
>   3960	
>   3961		pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size: %d\n",
>   3962			(int)(chip->chipsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
>   3963			mtd->erasesize >> 10, mtd->writesize, mtd->oobsize);
>   3964		return type;
>   3965	}
>   3966	
>   3967	/**
>   3968	 * It maps 'enum nand_ecc_modes_t' found in include/linux/mtd/nand.h
>   3969	 * into the device tree binding of 'nand-ecc', so that MTD
>   3970	 * device driver can get nand ecc from device tree.
>   3971	 */

I'll remove this kerneldoc header to avoid this warning.

> > 3972	static const char * const nand_ecc_modes[] = {
>   3973		[NAND_ECC_NONE]		= "none",
>   3974		[NAND_ECC_SOFT]		= "soft",
>   3975		[NAND_ECC_HW]		= "hw",
>   3976		[NAND_ECC_HW_SYNDROME]	= "hw_syndrome",
>   3977		[NAND_ECC_HW_OOB_FIRST]	= "hw_oob_first",
>   3978		[NAND_ECC_SOFT_BCH]	= "soft_bch",
>   3979	};
>   3980	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
