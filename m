From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
Date: Thu, 1 Sep 2011 16:15:48 +0200
Message-ID: <201109011615.49533.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
	<201109011559.33491.laurent.pinchart@ideasonboard.com>
	<CAK=WgbY0YTBVbHwHDDa-+8j8d_navvKN=JXFJDpdWp2BX0LFCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbY0YTBVbHwHDDa-+8j8d_navvKN=JXFJDpdWp2BX0LFCg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 01 September 2011 16:02:35 Ohad Ben-Cohen wrote:
> On Thu, Sep 1, 2011 at 4:59 PM, Laurent Pinchart
> 
> <laurent.pinchart@ideasonboard.com> wrote:
> > It looks good to me.
> 
> Thanks.
> 
> > I haven't tested it though.
> 
> I did, but I always get aligned buffers so my testing is a bit moot. I
> can't see how unmap could work without this patch, though, so I'll
> squash this and re-post.

You can allocate a page-aligned buffer with posix_memalign() and add an offset 
(64 should do the job, smaller values can get rejected by the OMAP3 ISP 
driver).

-- 
Regards,

Laurent Pinchart
