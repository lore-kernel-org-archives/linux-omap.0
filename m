From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] REGULATOR: TWL6025: add support to twl-regulator
Date: Wed, 27 Apr 2011 13:43:40 +0300
Message-ID: <20110427104339.GY13227@legolas.emea.dhcp.ti.com>
References: <1303897191-14792-1-git-send-email-gg@slimlogic.co.uk>
 <1303897191-14792-4-git-send-email-gg@slimlogic.co.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1303897191-14792-4-git-send-email-gg@slimlogic.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, balbi@ti.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Apr 27, 2011 at 10:39:50AM +0100, Graeme Gregory wrote:
> Adding support for the twl6025. Major difference in the twl6025 is the
> group functionality has been removed from the chip so this affects how
> regulators are enabled and disabled.
> 
> The names of the regulators also changed.
> 
> The DCDCs of the 6025 are software controllable as well.
> 
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> ---
>  drivers/regulator/twl-regulator.c |  447 ++++++++++++++++++++++++++++++++++---
>  1 files changed, 412 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 2a808c2..c08a0de 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -144,11 +158,14 @@ static int twl6030reg_is_enabled(struct regulator_dev *rdev)
>  	struct twlreg_info	*info = rdev_get_drvdata(rdev);
>  	int			grp, val;
>  
> -	grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
> -	if (grp < 0)
> -		return grp;
> +	if (!(twl_features() & TWL6025_SUBCLASS)) {

instead, why don't you pass some flag as platform_data to this driver,
which gets used to initialize a fiel in struct twlreg_info, then you use
that to do the checking.

> +		grp = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_GRP);
> +		if (grp < 0)
> +			return grp;
>  
> -	grp &= P1_GRP_6030;
> +		grp &= P1_GRP_6030;
> +	} else
> +		grp = 1;

if one branch has {} add it to both.

-- 
balbi
