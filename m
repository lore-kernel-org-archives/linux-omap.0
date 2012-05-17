From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 17 May 2012 14:22:23 +0100
Message-ID: <20120517132223.GB9650@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FB3D294.4020505@wwwdotorg.org>
 <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
 <201205161942.20296.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205161942.20296.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 16, 2012 at 07:42:20PM +0000, Arnd Bergmann wrote:
> On Wednesday 16 May 2012, Jassi Brar wrote:
> >  The assumed model of the DMAC, in this binding, has P peripheral
> > interfaces (P request signals) that could request a data transfer
> > and C physical channels that actually do the data transfers, hence,
> > at most C out of P peripherals could be served by the DMAC at any
> > point of time. Usually C := P, but not always. Usually, any of the
> > physical channels could be employed by the DMAC driver to serve any
> > client.
> >  The DMAC driver identifies a client by its i/f number, 'peri_id'
> > on the given DMAC. For example, TX for SPI has 7th while RX_TX
> > (half-duplex) for MMC has 10th peripheral interface (request-signal)
> > on a given DMAC. Usually, any of the physical channels could be
> > employed by the DMAC driver to serve a client.
> 
> I'm still anything but convinced by this model. Basically it's the
> exact opposite of what we do for every other subsystem (irq, pinctrl,
> regulator, gpio, ...), where the device using some infrastructure
> contains the information about who provides it, whereas here you
> move all the information into the device that provides the functionality,
> and have no handle in the device using it by which the driver can
> identify it.

I think the biggest difference between DMA and other subsystems is that
other systems have only one provider.

DMA on the other hand seems to have cases where you can make a choice
between two or more providers of the service.  The impression that I'm
getting from this thread is that it's difficult to describe that kind
of relationship in DT - DT is good at describing "A provides X to C"
but not "A _or_ B provides X to C and you can chose either A or B
depending on <something> to satisfy X".
