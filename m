From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Thu, 15 Mar 2012 20:41:53 +0000
Message-ID: <201203152041.53754.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <4F621939.9040906@ti.com>
 <20120315195753.GA2842@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120315195753.GA2842-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 15, 2012 at 05:30:49PM +0100, Cousson, Benoit wrote:
> > This was done like IRQ on purpose, because an Interrupt ReQuest line and  
> > a DMA Request line are really similar for the HW point of view at IP 
> > level.
> 
> I'm not sure about that at all levels.  Sure, at hardware level they're
> the same, but I think the flat numeric namespace for IRQs has been
> proven to be a problem when there's multiple IRQ controllers in the
> system.

In the DT bindings, both IRQ and the suggested DMA are not flat number
spaces, but instead can be of arbitrarly length defined by the controller.

> As far as I'm concerned for DMA stuff, there is currently no real solution
> for a DT representation; TI have asked me to take over the conversion of
> OMAP DMA support to the DMA engine API, and I'm not yet convinced that
> the existing numbering system is the right solution - especially as
> there's several overlapping numberspaces for OMAP DMA numbers which
> are SoC specific.

The numbers definitely need to become local to each of the controllers, but
that is the case pretty much automatically using the proposed binding,
because each dma request identifier starts with the phandle of the
controller.

	Arnd
