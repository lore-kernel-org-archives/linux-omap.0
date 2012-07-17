From: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [v3.6 3/3] iommu/tegra: smmu: Fix unsleepable memory allocation
	at alloc_pdir()
Date: Tue, 17 Jul 2012 15:23:00 +0200
Message-ID: <20120717132300.GK4213@amd.com>
References: <1341228398-6878-1-git-send-email-hdoyu@nvidia.com>
	<1341228398-6878-3-git-send-email-hdoyu@nvidia.com>
	<20120717100901.GH4213@amd.com>
	<20120717.152524.175499431618552821.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120717.152524.175499431618552821.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org" <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org" <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 17, 2012 at 02:25:24PM +0200, Hiroshi Doyu wrote:
> The above spin_lock is always necessary. "as->lock" should be held to
> protect "as->pdir_page". Only when "as->pdir_page" is NULL,
> "as->pdir_page" would be allocated in "alloc_pdir()". Without this
> lock, the following race could happen:
> 
> 
> Without as->lock:
> A:			B:
> i == 3
> pdir_page == NULL
> 			i == 3
> 	     		pdir_page == NULL
> pdir_page = a;
> 			pdir_page = b;	!!!!!! OVERWRITTEN !!!!!!
>

Unless I am missing something, this is not the correct situation with my
patch. It would look more like this:


 A:					B:
 i == 3
 pdir_page == NULL
 					i == 3
 	     				pdir_page == NULL

 take as->lock

 /* race check */
 pdir_page == NULL -> proceed		/* spinning on as->lock */

 pdir_page = a;

 release as->lock

					 take as->lock

					 /* race check */
					 pdir_page != NULL -> return

This should be fine, no? Do I miss something?


	Joerg
