From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: Add support to program multiple iommus
Date: Fri, 1 Sep 2017 18:33:12 +0200
Message-ID: <20170901163312.GM19533@8bytes.org>
References: <20170831131402.29502-1-s-anna@ti.com>
	<20170831131402.29502-3-s-anna@ti.com>
	<20170901100141.2ooccy7ns2fwxceg@8bytes.org>
	<d8b503a1-eaff-e4cc-215d-92520a91e205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d8b503a1-eaff-e4cc-215d-92520a91e205-l0cyMroinI0@public.gmane.org>
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
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Suman,
On Fri, Sep 01, 2017 at 11:21:45AM -0500, Suman Anna wrote:
> It's primarily a question of whether each iommu platform device need to
> be represented as a unique iommu_device or not. If you still think that
> both these need to be presented to iommu core as one device, I would
> have to add some glue logic in probe to tie the two devices together.

I think that you should only call iommu_device_register and friends for
the mmu-device you link the other devices against in .add_device.
Otherwise people will see two mmus in sysfs, one of them with no devices
behind it. That is inconsistent with the rest of the patch-set, which
basically handles bots mmus as one. But changing that should be easy, I
think.

Regards,

	Joerg
