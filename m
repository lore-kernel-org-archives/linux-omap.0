From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/3] ARM: DRA7: hwmod: Fixup SATA hwmod
Date: Thu, 3 Jul 2014 19:47:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407031947380.1515@utopia.booyaka.com>
References: <1404385274-5093-1-git-send-email-rogerq@ti.com> <1404385274-5093-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404385274-5093-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, rnayak@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 3 Jul 2014, Roger Quadros wrote:

> Get rid of optional clock as that is now managed by the
> AHCI platform driver.
> 
> Correct .mpu_rt_idx to 1 as the module register space (SYSCONFIG..)
> is passed as the second memory resource in the device tree.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks, this looks like a fix, so, queueing for v3.16-rc.


- Paul
