From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] omap: iommu: fixing NULL pointer return value
Date: Fri, 21 Dec 2012 15:39:50 +0200
Message-ID: <CAK=WgbaCU0q2t37k51_oVdmFO2uB6zUus-gV5X9O1xy1_GTOng@mail.gmail.com>
References: <1356096979-27698-1-git-send-email-g-aubertin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1356096979-27698-1-git-send-email-g-aubertin-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Guillaume Aubertin <g-aubertin-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, lo <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Guillaume,

You should also cc Joerg and the iommu ml for iommu patches (cc'ing now).

On Fri, Dec 21, 2012 at 3:36 PM, Guillaume Aubertin <g-aubertin-l0cyMroinI0@public.gmane.org> wrote:
> the returned NULL pointer is not detected by IS_ERR(), and then
> de-referenced in the calling function, omap_iommu_attach_dev().
>
> Signed-off-by: Guillaume Aubertin <g-aubertin-l0cyMroinI0@public.gmane.org>

Acked-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/iommu/omap-iommu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index badc17c..a0fcad2 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -861,7 +861,7 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
>                                 (void *)name,
>                                 device_match_by_alias);
>         if (!dev)
> -               return NULL;
> +               return ERR_PTR(-ENODEV);
>
>         obj = to_iommu(dev);
>
> --
> 1.7.0.4
>
