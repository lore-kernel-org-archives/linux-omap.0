From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv2 1/2] iommu/omap: Check for valid archdata in attach_dev
Date: Fri, 05 Sep 2014 14:12:34 +0300
Message-ID: <2089748.loWtuY0IUs@avalon>
References: <1409869650-26115-1-git-send-email-s-anna@ti.com>
	<1409869650-26115-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409869650-26115-2-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

Thank you for the patch.

On Thursday 04 September 2014 17:27:29 Suman Anna wrote:
> Any device requiring to be attached to an iommu_domain must have
> valid archdata containing the necessary iommu information, which
> is SoC-specific. Add a check in the omap_iommu_attach_dev to make
> sure that the device has valid archdata before accessing
> different SoC-specific fields of the archdata. This prevents a
> NULL pointer dereference on any misconfigured devices.
> 
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/iommu/omap-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 02ef0ac..ea6e59d 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1090,6 +1090,11 @@ omap_iommu_attach_dev(struct iommu_domain *domain,
> struct device *dev) struct omap_iommu_arch_data *arch_data =
> dev->archdata.iommu;
>  	int ret = 0;
> 
> +	if (!arch_data || !arch_data->name) {
> +		dev_err(dev, "device doesn't have an associated iommu\n");
> +		return -EINVAL;
> +	}
> +
>  	spin_lock(&omap_domain->lock);
> 
>  	/* only a single device is supported per domain for now */

-- 
Regards,

Laurent Pinchart
