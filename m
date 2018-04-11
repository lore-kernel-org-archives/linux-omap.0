From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2] media: omap3isp: fix unbalanced dma_iommu_mapping
Date: Wed, 11 Apr 2018 19:26:56 +0300
Message-ID: <20180411162655.gigmuzna624xcxx2@valkosipuli.retiisi.org.uk>
References: <20180314154136.16468-1-s-anna@ti.com> <5767280.aLITpzbm0N@avalon>
 <e0151287-f294-3540-9b12-a96e05db61c0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e0151287-f294-3540-9b12-a96e05db61c0@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 26, 2018 at 11:40:58AM -0500, Suman Anna wrote:
> Hi Mauro,
> 
> On 03/21/2018 05:26 AM, Laurent Pinchart wrote:
> > Hi Suman,
> > 
> > Thank you for the patch.
> > 
> > On Wednesday, 14 March 2018 17:41:36 EET Suman Anna wrote:
> >> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
> >> ARM DMA backend. The current code creates a dma_iommu_mapping and
> >> attaches this to the ISP device, but never detaches the mapping in
> >> either the probe failure paths or the driver remove path resulting
> >> in an unbalanced mapping refcount and a memory leak. Fix this properly.
> >>
> >> Reported-by: Pavel Machek <pavel@ucw.cz>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I don't see this patch in -next yet, can you pick up this patch at your
> earliest?

Here:

<URL:https://patchwork.linuxtv.org/patch/48599/>

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
