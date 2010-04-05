From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v3] OMAP: Fix for bus width which improves SD card's
 peformance.
Date: Mon, 5 Apr 2010 19:48:39 +0300
Message-ID: <20100405164839.GB17388@gandalf>
References: <35697.192.168.10.89.1265898023.squirrel@dbdmail.itg.ti.com>
 <004701caab40$68b576e0$544ff780@am.dhcp.ti.com>
 <x2q7f9d1ffb1003302307nb8e91be0o55da59c3375f1720@mail.gmail.com>
 <v2yce9ab5791003302327hc67deb3akc7d18146534038f9@mail.gmail.com>
 <h2p7f9d1ffb1003310003z508e21dbqe37b6e1cad425866@mail.gmail.com>
 <003b01cad0f0$6ea78040$544ff780@am.dhcp.ti.com>
 <g2s7f9d1ffb1003312331o149df218g651c3e4349ac9a77@mail.gmail.com>
 <003c01cad1b1$da2cdbf0$544ff780@am.dhcp.ti.com>
 <m2n7f9d1ffb1004050556o1ed2eec8ief66d60fc85f96de@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m2n7f9d1ffb1004050556o1ed2eec8ief66d60fc85f96de@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishore kadiyala <kishorek.kadiyala@gmail.com>
Cc: Madhusudhan <madhu.cr@ti.com>, Vimal Singh <vimal.newwork@gmail.com>, tony@atomide.com, svenkatr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, jarkko.lavinen@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Apr 05, 2010 at 06:26:16PM +0530, kishore kadiyala wrote:
> @@ -2091,9 +2091,9 @@ static int __init omap_hsmmc_probe(struct
>  	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>  		     MMC_CAP_WAIT_WHILE_BUSY;
> 
> -	if (mmc_slot(host).wires >= 8)
> -		mmc->caps |= MMC_CAP_8_BIT_DATA;
> -	else if (mmc_slot(host).wires >= 4)
> +	if (mmc_slot(host).wires == 8)
> +		mmc->caps |= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA);
> +	else if (mmc_slot(host).wires == 4)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;

I believe it would be enough to just remove the 'else', so the code
would look like:

if (mmc_slot(host).wires >= 8)
	mmc->caps |= MMC_CAP_8_BIT_DATA;
if (mmc_slot(host).wires >= 4)
	mmc->caps |= MMC_CAP_4_BIT_DATA;

-- 
balbi
