From: Tony Lindgren <tony@atomide.com>
Subject: Re: Moving I2C2 init to plat-omap/devices.c  ?
Date: Thu, 16 Nov 2006 03:01:33 +0200
Message-ID: <20061116010133.GL21064@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01E41F96@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01E41F96@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061115 22:28]:
> Hello,
> 
> I would like to enable I2C support for 2430. I see I2C1 device
> initialization defined in arch/arm/plat-omap/devices.c and I2C2 in
> arch/arm/mach-omap2/devices.c. I believe the reason for this might be to
> move the common part (I2C1) to plat-omap. 
> 
> I was thinking of moving the I2C2 initialization from
> mach-omap2/devices.c to plat-omap/devices.c. The reason is OMAP1 has 1
> I2C block, OMAP2 has 2 and OMAP3 has 4 (1 dedicated). The I2C register
> base addresses are same for 2420, 2430 and 3430. So, adding same code in
> two directories looks redundant. 
> 
> Let me know if you see any issues with this approach.

Well most of that code is just data for the ports. And it sounds like
you're assuming that omap3 is a separate directory and "completely different"
from omap2.. Until we've seen some patches and docs, I don't think we
can make that assumption.

Regards,

Tony
