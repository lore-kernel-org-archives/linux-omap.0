From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL FOR v3.16] OMAP IOMMU fixes
Date: Wed, 16 Apr 2014 16:01:07 +0200
Message-ID: <20140416140107.GA3627@8bytes.org>
References: <2312051.xNuD1CfeZH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2312051.xNuD1CfeZH@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Fri, Apr 04, 2014 at 12:11:52AM +0200, Laurent Pinchart wrote:
> Laurent Pinchart (3):
>       iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
>       iommu/omap: Remove comment about supporting single page mappings only
>       iommu/omap: Fix map protection value handling
> 
> Suman Anna (3):
>       iommu/omap: Correct init value of iotlb_entry valid field
>       iommu/omap: Remove omap_iommu_domain_has_cap() function
>       iommu/omap: Move to_iommu definition from omap-iopgtable.h
> 
>  drivers/iommu/omap-iommu.c     | 31 ++++++++++++-------------------
>  drivers/iommu/omap-iopgtable.h |  3 ---
>  2 files changed, 12 insertions(+), 22 deletions(-)

Can you please rebase this to v3.15-rc1 and send a new pull request? I
get a lot of commits besides these when I pull into v3.15-rc1.


	Joerg
