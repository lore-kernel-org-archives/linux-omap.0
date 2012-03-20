From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 1/2] of: Add generic device tree DMA helpers
Date: Tue, 20 Mar 2012 13:03:10 +0000
Message-ID: <201203201303.11175.arnd@arndb.de>
References: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 March 2012, Nicolas Ferre wrote:
> 
> Add some basic helpers to retrieve a DMA controller device_node and the
> DMA request specifications. By making DMA controllers register a generic
> translation function, we allow the management of any type of DMA requests
> specification.
> The void * output of an of_dma_xlate() function that will be implemented
> by the DMA controller can carry any type of "dma-request" argument.
> 
> The DMA client will search its associated DMA controller in the list and
> call the registered of_dam_xlate() function to retrieve the request values.
> 
> One simple xlate function is provided for the "single number" type of
> request binding.
> 
> This implementation is independent from dmaengine so it can also be used
> by legacy drivers.

Thanks a lot of posting this updated version, I think it will be very
useful as we proceed. I still hope that in the end we find that the
differences are not all that big and we can do it all with bindings
very much like what you have here.

	Arnd
