From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/2] spi: Add DMA support for spi_flash_read()
Date: Wed, 8 Jun 2016 12:21:54 +0530
Message-ID: <5757C08A.9010506@ti.com>
References: <201606080659.2i234CnZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201606080659.2i234CnZ%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Wednesday 08 June 2016 03:59 AM, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on spi/for-next]
> [also build test ERROR on v4.7-rc2 next-20160607]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Vignesh-R/spi-Add-DMA-support-for-ti-qspi/20160607-162134
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi for-next
> config: m32r-allyesconfig (attached as .config)
> compiler: m32r-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=m32r 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/spi/spi.c: In function 'spi_flash_read':
>>> drivers/spi/spi.c:2758:3: error: implicit declaration of function 'spi_map_buf' [-Werror=implicit-function-declaration]
>       ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
>       ^
>>> drivers/spi/spi.c:2766:3: error: implicit declaration of function 'spi_unmap_buf' [-Werror=implicit-function-declaration]
>       spi_unmap_buf(master, rx_dev, &msg->rx_sg,
>       ^
>    cc1: some warnings being treated as errors
> 


Oops, posted v4 fixing these errors.


-- 
Regards
Vignesh
