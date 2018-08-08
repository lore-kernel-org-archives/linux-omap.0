From: 'Joerg Roedel' <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/omap: Fix cache flushes on L2 table entries
Date: Wed, 8 Aug 2018 11:08:43 +0200
Message-ID: <20180808090843.vz7lpydotmfafkli@8bytes.org>
References: <7c58d42f-cb11-129a-6e04-45319443f1bb@ti.com>
	<20180806150036.14644-1-ralf.goebel@imago-technologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180806150036.14644-1-ralf.goebel-XQ0Z+IutXF4FoECaAgFIynS5uNuOjpZe@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ralf Goebel <ralf.goebel-XQ0Z+IutXF4FoECaAgFIynS5uNuOjpZe@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'KISHON VIJAY ABRAHAM' <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 06, 2018 at 05:00:36PM +0200, Ralf Goebel wrote:
> The base address used for DMA operations on the second-level table
> did incorrectly include the offset for the table entry. The offset
> was then added again which lead to incorrect behavior.
> 
> Operations on the L1 table are not affected.
> 
> The calculation of the base address is changed to point to the
> beginning of the L2 table.
> 
> Fixes: bfee0cf0ee1d ("iommu/omap: Use DMA-API for performing cache flushes")
> Acked-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ralf Goebel <ralf.goebel-XQ0Z+IutXF4FoECaAgFIynS5uNuOjpZe@public.gmane.org>

Applied for v4.19, thanks.
