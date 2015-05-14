From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 0/8] dmaengine/dra7x: DMA router (crossbar support)
Date: Thu, 14 May 2015 20:51:31 +0530
Message-ID: <20150514152131.GJ5418@localhost>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <20150509114423.GK3521@localhost>
 <5553663F.9040604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5553663F.9040604@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com
List-Id: linux-omap@vger.kernel.org

On Wed, May 13, 2015 at 05:57:03PM +0300, Peter Ujfalusi wrote:
> On 05/09/2015 02:44 PM, Vinod Koul wrote:
> >> This implementation is not tied to any DMA driver so it is possible to use the
> >> framework by other vendors, also ACPI version of binding can be easy enough to
> >> be added.
> > I have applied all but last change to topic/omap
> 
> I can only find 6 patches out of the 8 in topic/omap. Patch 3 - which is the
> main reason for this series seams to be missing but the binding document patch
> for the ti-dma-crossbar is there.
Oops, I thought i selected whole series except 8th one!. I have picked the
missing 3rd patch and applied now

Since noone complained so am assuming sequence isn't broken which is nice, if
you feel we should reorder and place it 3rd, let me know

-- 
~VInod
