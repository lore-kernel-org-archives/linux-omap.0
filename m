From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd/regulator: tps65217: Move regulator plat data
 handling to regulator
Date: Fri, 27 Jul 2012 14:48:17 +0200
Message-ID: <20120727124816.GM16859@sortiz-mobl>
References: <1342776601-8773-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342776601-8773-1-git-send-email-anilkumar@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, dan.carpenter@oracle.com, rdunlap@xenotime.net, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Anilkumar,

On Fri, Jul 20, 2012 at 03:00:01PM +0530, AnilKumar Ch wrote:
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
> This patch is based on linux-next (20120720) tree
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  drivers/mfd/tps65217.c                 |  130 +++++++++++---------------------
>  drivers/regulator/tps65217-regulator.c |  124 ++++++++++++++++++++++++++----
>  include/linux/mfd/tps65217.h           |   12 ++-
>  3 files changed, 161 insertions(+), 105 deletions(-)
It doesn't apply to my for-next branch. Could you please re-send this one
after the merge window is closed ? I'll push that as part of the MFD fixes for
3.6.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
