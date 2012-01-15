From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 2/2] regulator: tps65217: Add tps65217 regulator driver
Date: Sun, 15 Jan 2012 12:20:10 +0000
Message-ID: <20120115122009.GF3040@opensource.wolfsonmicro.com>
References: <1326278509-31310-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1326278509-31310-1-git-send-email-anilkumar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: sameo@linux.intel.com, lrg@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2012 at 04:11:49PM +0530, AnilKumar Ch wrote:

> +	rdev = regulator_register(&regulators[pdev->id], &pdev->dev,
> +				  pdev->dev.platform_data, tps);

Oh, actually - this needs redoing against -next, regulator_register now
takes an additional of_node argument.  If there's no device tree support
it can be null.
