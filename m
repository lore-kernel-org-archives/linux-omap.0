From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Mon, 30 Nov 2015 09:26:19 -0800
Message-ID: <20151130172619.GF2517@atomide.com>
References: <20151006100000.GN23801@atomide.com>
 <56139CE9.8020002@ti.com>
 <5613A256.8000105@ti.com>
 <20151006110134.GO23801@atomide.com>
 <5613ABEF.9000904@ti.com>
 <20151016212510.GF24370@atomide.com>
 <562496DB.4050803@ti.com>
 <56274D69.1090402@ti.com>
 <20151021152028.GO3078@atomide.com>
 <5629DD1F.60506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5629DD1F.60506@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, computersforpeace@gmail.com, dwmw2@infradead.org, fcooper@ti.com
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [151023 00:09]:
> On 21/10/15 18:20, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [151021 01:31]:
> >>
> >> I couldn't run randconfig beyond few iterations as it keeps failing
> >> everywhere. How do we limit the randconfig options to OMAP only
> >> platforms?
> > 
> > You can use Felipe's scripts from github.
> 
> Thanks. I used his scripts and ran 10 randconfigs per platform.
> Didn't find any issues with this series.
> 
> How can we proceed?
> Patches are on https://github.com/rogerq/linux/commits/for-v4.4/gpmc-v4

Sorry for the delay on this one. I suggest you get this series into
linux next and then we can merge it for v4.5 via arm-soc as long as
the pending comments are addressed. As far as I'm concerned, feel free
to add for the whole series:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
