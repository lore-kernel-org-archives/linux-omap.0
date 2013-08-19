From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v12 10/11] ARM: dts: add AM33XX EDMA support
Date: Mon, 19 Aug 2013 16:22:53 +0200
Message-ID: <52122A3D.8040305@linutronix.de>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com> <1371762407-24544-11-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1371762407-24544-11-git-send-email-joelagnel@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Joel A Fernandes <joelagnel@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Jason Kridner <jkridner@beagleboard.org>, Koen Kooi <koen@beagleboard.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kern>
List-Id: linux-omap@vger.kernel.org

On 06/20/2013 11:06 PM, Joel A Fernandes wrote:
> From: Matt Porter <mdp@ti.com>
> 
> Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> Documentation/devicetree/bindings/dma/ti-edma.txt
> 
> Joel: Drop DT entries that are non-hardware-description for now as discussed in [1]
> 
> [1] https://patchwork.kernel.org/patch/2226761/
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>

I've been browsing my lkml folders and I haven't seen any later version
of this patch. It seems that other patches from this series have been
applied. I don't see this patch in linux-next as of Friday. Any reason
why this has not been applied yet?

Sebastian
