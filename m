From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] dmaengine: add dma_get_slave_sg_limits()
Date: Thu, 18 Jul 2013 21:46:58 +0530
Message-ID: <20130718161658.GW16653@intel.com>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
 <1374166001-31340-2-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374166001-31340-2-git-send-email-joelf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>L
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 18, 2013 at 11:46:39AM -0500, Joel Fernandes wrote:
> From: Matt Porter <mporter@ti.com>
> 
> Add a dmaengine API to retrieve slave SG transfer limits.
> 
> The API is optionally implemented by dmaengine drivers and when
> unimplemented will return a NULL pointer. A client driver using
> this API provides the required dma channel, address width, and
> burst size of the transfer. dma_get_slave_sg_limits() returns an
> SG limits structure with the maximum number and size of SG segments
> that the given channel can handle.
Hi Joel,

I have already resurrected this and generalized the API to get the slave
capablities. 
https://lkml.org/lkml/2013/7/15/147

Please start using this API

~Vinod
