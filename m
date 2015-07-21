From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 07/11] iommu/omap: Remove unnecessary error traces on
	alloc failures
Date: Tue, 21 Jul 2015 19:03:18 +0300
Message-ID: <110578668.3031HDm9MJ@avalon>
References: <1437431613-55656-1-git-send-email-s-anna@ti.com>
	<1437431613-55656-8-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437431613-55656-8-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Suman,

Thank you for the patch.

On Monday 20 July 2015 17:33:29 Suman Anna wrote:
> Fix couple of checkpatch warnings of the type,
>     "WARNING: Possible unnecessary 'out of memory' message"
> 
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

The commit message could also mention that the reason to remove the error 
messages is that memory allocation failures will already be reported in the 
kernel log by the memory management code. No big deal though,

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/iommu/omap-iommu.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 0fc00f31c39d..4328d9855edb 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1093,16 +1093,12 @@ static struct iommu_domain
> *omap_iommu_domain_alloc(unsigned type) return NULL;
> 
>  	omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
> -	if (!omap_domain) {
> -		pr_err("kzalloc failed\n");
> +	if (!omap_domain)
>  		goto out;
> -	}
> 
>  	omap_domain->pgtable = kzalloc(IOPGD_TABLE_SIZE, GFP_KERNEL);
> -	if (!omap_domain->pgtable) {
> -		pr_err("kzalloc failed\n");
> +	if (!omap_domain->pgtable)
>  		goto fail_nomem;
> -	}
> 
>  	/*
>  	 * should never fail, but please keep this around to ensure

-- 
Regards,

Laurent Pinchart
