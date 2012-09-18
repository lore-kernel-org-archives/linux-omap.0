From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Tue, 18 Sep 2012 12:50:05 +0000
Message-ID: <201209181250.05647.arnd@arndb.de>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <201209172042.11860.arnd@arndb.de> <20120917230615.GA26502@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120917230615.GA26502-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 17 September 2012, David Brown wrote:
> There is also a lot of similarity between the mmci hardware and the
> msm_sdcc hardware.  Enough so, that it is probably better for us to
> make the mmci driver work with our hardware, rather than trying to
> keep msm_sdcc going.
> 
> There is also an MSM nand device that appears to have not made it in.
> It is heavily dependent on the weird features of the DMA hardware.  I
> don't have any current plans to support this device, since most boards
> using MSMs these days are using mmc/sd instead of bare NAND.
> 
> Our DMA hardware is really weird, but should be a bit reasonable.  It
> is also being gradually replaced in newer chips with a different DMA
> framework.
> 
> As far as I'm concerned, I consider making our DMA driver(s) use the
> DMA engine API to be part of getting these platforms working with DT.
> 
> It is planned, but there are quite a few things that need to be
> tackled first.

Ok, thanks for the information.

	Arnd
