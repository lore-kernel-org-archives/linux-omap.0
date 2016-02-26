From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 0/9] ARM: dts: omap2+: GPMC NAND node fixes
Date: Fri, 26 Feb 2016 10:44:32 -0800
Message-ID: <20160226184431.GB13417@atomide.com>
References: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456245445-31824-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: computersforpeace@gmail.com, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Roger Quadros <rogerq@ti.com> [160223 08:37]:
> Hi Tony,
> 
> These patches are a preparatory step towards the NAND DT cleanup
> done in [1].

OK great NAND keeps working for me. I've pushed these into an
immutable branch against v4.5-r1 named omap-for-v4.6/dt-gpmc.

I have also merged that branch into omap-for-v4.6/dt.

Please feel free to use omap-for-v4.6/dt-gpmc branch as an
immutable base for the GPMC driver changes.

And please let me know what additional patches I may need to
apply into omap-for-v4.6/dt for new files that are not in
omap-for-v4.6/dt-gpmc.

Note that I also fixed two typos below:

> Roger Quadros (9):
>   ARM: dts: dra7: Fix NAND device nodes.

I removed the trailing period here.

>   ARM: dts: dra7: Remove redundant nand property
>   ARM: dts: am437x: Fix NAND device nodes
>   ARM: dts: am437x: Disable wait pin monitoring for NAND
>   ARM: dts: am335x: Fix NAND device nodes
>   ARM: dts: am335x: Disable wait pin monitoring for NAND
>   ARM: dts: dm816x: Fix NAND device nodes
>   ARM: dts: dm8168-evm: ARM: dts: Disable wait pin monitoring for NAND
>   ARM: dts: omap3: Fix NAND device nodess

I removed the extra s in nodes here.

Regards,

Tony
