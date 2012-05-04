From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 4 May 2012 16:14:23 +0100
Message-ID: <20120504151423.GA26585@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA30604.1030401@wwwdotorg.org> <4FA3F08D.7030603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA3F08D.7030603-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 04, 2012 at 10:06:53AM -0500, Jon Hunter wrote:
> The thought here was that some DMAs may distinguish between devices by a
> request ID or a channel ID or both. In the case of say an OMAP4, we have
> 32 channels and 127 request IDs. From a h/w perspective we need to know
> both. Each of the 32 channels can be programmed to use any one of the
> 127 h/w request signals.
> 
> Other DMAs may only need to specify requests or channels. However, the
> thought was you could specific either or both depending on your needs.
> Again these should have been optional parameters.

As being the one who is converting you over to DMA engine, I can't agree
with what you've just said.  I don't see that there's anything specific
to any particular DMA channel.  I don't see that a driver would need to
obtain a reference to any particular channel.

This seems to be supported by the current OMAP DMA API which merely
returns any one of the 32 channels that it can find whenever
omap_request_dma() is called.

At the moment, the DMA engine support I'm working on totally hides the
physical DMA channels behind a set of virtual DMA channels, one for each
DMA request signal.  This appears to work well, and is compatible with
how existing drivers use the current OMAP DMA API.
