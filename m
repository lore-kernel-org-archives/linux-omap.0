From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] regulator:TPS65910: VDD1/2 voltage selector count
Date: Fri, 4 Nov 2011 14:04:22 +0000
Message-ID: <20111104140422.GA28615@opensource.wolfsonmicro.com>
References: <1320410928-20349-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320410928-20349-1-git-send-email-afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-kernel@vger.kernel.org, lrg@ti.com, sameo@linux.intel.com, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2011 at 06:18:48PM +0530, Afzal Mohammed wrote:

>  		if (i == TPS65910_REG_VDD1 || i == TPS65910_REG_VDD2) {
>  			pmic->desc[i].ops = &tps65910_ops_dcdc;
> +			pmic->desc[i].n_voltages = VDD1_2_NUM_VOLTS * 3;

This looks suspicous - what's the * 3 about?
