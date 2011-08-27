From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to handle named resources with DT?
Date: Sat, 27 Aug 2011 14:00:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108271252100.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
	<201108261258.32880.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201108261258.32880.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Cousson,
	Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: linux-omap@vger.kernel.org

On Fri, 26 Aug 2011, Arnd Bergmann wrote:

> I don't think anyone was talking about converting driver /to/ the
> _byname method

For drivers that use multiple resources of the same type, converting those 
to use platform_get_resource_byname() does indeed seem appropriate.

By the way, the same IP block design can exist on platforms with different 
device data formats.  For example, the PowerVR SGX core[1] is present on 
many ARM SoCs and on Intel Poulsbo designs.  The Poulsbo systems are 
presumably using ACPI/SFI *SDT tables.  So it seems unwise to couple 
drivers to any specific external device data format.


- Paul

1. One example: http://en.wikipedia.org/wiki/PowerVR#Series5_.28SGX.29
