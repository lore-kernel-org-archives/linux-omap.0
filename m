From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] mfd/regulator: tps65217: Move regulator plat data
 handling to regulator
Date: Wed, 22 Aug 2012 11:02:29 +0200
Message-ID: <20120822090229.GC9889@sortiz-mobl>
References: <1344870365-11645-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344870365-11645-1-git-send-email-anilkumar@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, dan.carpenter@oracle.com, rdunlap@xenotime.net, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi AnilKumar,

On Mon, Aug 13, 2012 at 08:36:05PM +0530, AnilKumar Ch wrote:
> Regulator platform data handling was mistakenly added to MFD
> driver. So we will see build errors if we compile MFD drivers
> without CONFIG_REGULATOR. This patch moves regulator platform
> data handling from TPS65217 MFD driver to regulator driver.
> 
> This makes MFD driver independent of REGULATOR framework so
> build error is fixed if CONFIG_REGULATOR is not set.
> 
> drivers/built-in.o: In function `tps65217_probe':
> tps65217.c:(.devinit.text+0x13e37): undefined reference
> to `of_regulator_match'
> 
> This patch also fix allocation size of tps65217 platform data.
> Current implementation allocates a struct tps65217_board for each
> regulator specified in the device tree. But the structure itself
> provides array of regulators so one instance of it is sufficient.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> This patch is tested on BeagleBone with regulator device node
> additions. And this is based on mfd/master.
> 
> Changes from v1:
> 	- Incorporated Matthias Kaehlcke's commets on v1
> 	  * Fixed allocation size of tps65217 platform data
> 
>  drivers/mfd/tps65217.c                 |  130 +++++++++++---------------------
>  drivers/regulator/tps65217-regulator.c |  124 ++++++++++++++++++++++++++----
>  include/linux/mfd/tps65217.h           |   12 ++-
>  3 files changed, 161 insertions(+), 105 deletions(-)
> 
Applied to my for-next and for-linus branches, thanks.
Btw, this is too big of a patch for stable.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
