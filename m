From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 5/7] iommu/msm: ->unmap() should return order of unmapped
	page
Date: Fri, 2 Sep 2011 11:36:34 -0700
Message-ID: <20110902183634.GA25775@huya.qualcomm.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
	<1314984756-4400-6-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1314984756-4400-6-git-send-email-ohad@wizery.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Stepan Moskovchenko <stepanm@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 02, 2011 at 08:32:34PM +0300, Ohad Ben-Cohen wrote:
> Users of the IOMMU API (kvm specifically) assume that iommu_unmap()
> returns the order of the unmapped page (on success).
> 
> Fix msm_iommu_unmap() accordingly.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> ---
>  drivers/iommu/msm_iommu.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 1a584e0..d1733f6 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -543,6 +543,13 @@ static int msm_iommu_unmap(struct iommu_domain *domain, unsigned long va,
>  	}
>  
>  	ret = __flush_iotlb(domain);
> +
> +	/*
> +	 * the IOMMU API requires us to return the order of the unmapped
> +	 * page (on success).
> +	 */
> +	if (!ret)
> +		ret = order;
>  fail:
>  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
>  	return ret;

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
