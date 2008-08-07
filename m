From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 7 Aug 2008 08:30:35 +0100
Message-ID: <20080807073035.GA10255@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	<1218016428.25235.11.camel@pc1117.cambridge.arm.com>
	<13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 06, 2008 at 07:21:14AM -0500, Woodruff, Richard wrote:
> Most of the weak memory attributes in newer ARMs are not exploited
> today in tree.  I'll guess this was more a correctness and capability
> judgment from Russell.

Not entirely true.  We do as much as is safe to do - which is basically
using 'device' mappings for devices and ioremap, and 'memory' mappings
for the main memory, module and vmalloc mappings.

What we don't do is mark DMA memory ask being normal uncached memory,
thereby allowing that to be reordered with device accesses - we make
it strongly ordered.  The reason being that the kernel doesn't have
barriers necessary to ensure that writes to DMA memory hit physical
memory before the device access to enable DMA hits the DMA controller.

Those kinds of bugs can be absolute hell to track down - think about
a DMA controller accessing an uninitialised DMA descriptor, resulting
in it scribbing over random bits of memory.

The only real way to do this is to audit lots of drivers to ensure
that:

1. DMA is not started until accesses to memory allocated by
   dma_alloc_coherent() have hit memory
2. accesses to dma_alloc_coherent() memory always read current data, even
   if the DMA controller has just updated the descriptor you're reading.

Linux presently - and quite rightly - assumes that accesses to DMA
coherent memory _are_ coherent with DMA.  If not, the API would be
a joke.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
