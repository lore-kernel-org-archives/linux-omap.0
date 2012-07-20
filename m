From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] net: ethernet: davinci_emac: add pm_runtime support
Date: Fri, 20 Jul 2012 14:42:51 -0700
Message-ID: <20120720214251.GC22263@animalcreek.com>
References: <1342736577-30477-1-git-send-email-mgreer@animalcreek.com>
 <50095B8C.3050502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50095B8C.3050502@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, David Miller <davem@davemloft.net>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 20, 2012 at 06:52:20PM +0530, Sekhar Nori wrote:
> + Dave Miller and DaVinci list
> 
> Hi Mark,
> 
> On 7/20/2012 3:52 AM, Mark A. Greer wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > Add pm_runtime support to the TI Davinci EMAC driver.
> > 
> > CC: Sekhar Nori <nsekhar@ti.com>
> > CC: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> Tested on AM18x EVM using NFS root and suspend-to-RAM.
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks for testing, Sekhar.

Mark
