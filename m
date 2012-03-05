From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arch/arm/mach-omap2/: included some headers twice
Date: Mon, 5 Mar 2012 14:13:57 -0800
Message-ID: <20120305221357.GA12083@atomide.com>
References: <1329403502-32494-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329403502-32494-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: Danny Kukawka <dkukawka@suse.de>, Russell King <linux@arm.linux.org.uk>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Danny Kukawka <danny.kukawka@bisect.de> [120216 06:13]:
> arch/arm/mach-omap2/: included some headers tiwce:
> - arch/arm/mach-omap2/board-ldp.c: 'linux/gpio.h'
> - arch/arm/mach-omap2/io.c: 'common.h'
> - arch/arm/mach-omap2/omap_hwmod_44xx_data.c: 'plat/i2c.h'
> 
> Remove the duplicates.

Thanks applying this too.

Regards,

Tony
