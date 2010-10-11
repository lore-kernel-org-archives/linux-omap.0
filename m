From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] regulator: fix build when CONFIG_REGULATOR_DUMMY=n
Date: Mon, 11 Oct 2010 22:22:35 +0100
Message-ID: <1286832155.3283.21.camel@odin>
References: <1286814955-23415-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286814955-23415-1-git-send-email-gadiyar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2010-10-11 at 22:05 +0530, Anand Gadiyar wrote:
> Commit f03f91826 (regulator: Add option for machine drivers
> to enable the dummy regulator) in the regulators tree
> seems to have introduced the following build break when
> CONFIG_REGULATOR_DUMMY is disabled. Fix this.
> 
>   CC      drivers/regulator/dummy.o
> drivers/regulator/dummy.c:41: error: redefinition of 'regulator_dummy_init'
> drivers/regulator/dummy.h:28: note: previous definition of 'regulator_dummy_init' was here
> make[2]: *** [drivers/regulator/dummy.o] Error 1
> make[1]: *** [drivers/regulator] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> The commit referenced above is in linux next as of 20101011
> and breaks builds of the omap2plus_defconfig at least.
> 
>  drivers/regulator/dummy.h |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: mainline/drivers/regulator/dummy.h
> ===================================================================
> --- mainline.orig/drivers/regulator/dummy.h
> +++ mainline/drivers/regulator/dummy.h
> @@ -22,10 +22,6 @@ struct regulator_dev;
>  
>  extern struct regulator_dev *dummy_regulator_rdev;
>  
> -#ifdef CONFIG_REGULATOR_DUMMY
>  void __init regulator_dummy_init(void);
> -#else
> -static inline void regulator_dummy_init(void) { }
> -#endif
>  
>  #endif

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
