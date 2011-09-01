From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
Date: Thu, 1 Sep 2011 15:31:13 +0200
Message-ID: <201109011531.13980.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
	<CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
	<CAK=WgbaOSaKcxmsG2L3G3g+bORvtq4nyzCg9yhA=tTLhsYmh3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=WgbaOSaKcxmsG2L3G3g+bORvtq4nyzCg9yhA=tTLhsYmh3w@mail.gmail.com>
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

Hi Ohad,

On Thursday 01 September 2011 13:47:26 Ohad Ben-Cohen wrote:
> On Wed, Aug 31, 2011 at 1:52 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > omap_iovmm requires page-aligned buffers, and that sometimes causes
> > omap3isp failures (i.e. whenever the buffer passed from userspace is not
> > page-aligned).
> > 
> > Remove this limitation by rounding the address of the first page entry
> > down, and adding the offset back to the device address.
> 
> Seems like the unmap paths were skipped (need to adjust the sizes in
> the unmap path too).
> 
> Laurent, if it looks good to you, I'll just squash it to the original
> patch and repost:

Do you have a tree where the current code base can be found ?

> diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
> index d28a256..39bdb92 100644
> --- a/drivers/iommu/omap-iovmm.c
> +++ b/drivers/iommu/omap-iovmm.c
> @@ -447,7 +447,7 @@ err_out:
>         for_each_sg(sgt->sgl, sg, i, j) {
>                 size_t bytes;
> 
> -               bytes = sg->length;
> +               bytes = sg->length + sg->offset;
>                 order = get_order(bytes);
> 
>                 /* ignore failures.. we're already handling one */
> @@ -476,7 +476,7 @@ static void unmap_iovm_area(struct iommu_domain
> *domain, str size_t bytes;
>                 int order;
> 
> -               bytes = sg->length;
> +               bytes = sg->length + sg->offset;
>                 order = get_order(bytes);
> 
>                 err = iommu_unmap(domain, start, order);

-- 
Regards,

Laurent Pinchart
