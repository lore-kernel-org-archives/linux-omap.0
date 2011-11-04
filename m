From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] mfd: TPS65910: Improvements
Date: Fri, 4 Nov 2011 15:24:11 +0000
Message-ID: <20111104152411.GB28615@opensource.wolfsonmicro.com>
References: <1320410912-20293-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320410912-20293-1-git-send-email-afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-kernel@vger.kernel.org, lrg@ti.com, sameo@linux.intel.com, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 04, 2011 at 06:18:32PM +0530, Afzal Mohammed wrote:
> Two changes,

...should be in two separate commits.

> 2. struct tps65910_platform_data usage can be avoided
>  by making use of struct tps65910_board to simplify
>  driver. Hence remove it

Why is this a simplification?  Note that one of the reasons platform
data is kept separate from any runtime data the device needs is that it
makes the configuration available easier to see and understand.
