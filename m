From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 00/13] OMAP IOMMU DT adaptation for 3.15
Date: Tue, 4 Mar 2014 17:04:32 +0100
Message-ID: <20140304160432.GG2799@8bytes.org>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
	<20140228230000.GW13624@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140228230000.GW13624-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 28, 2014 at 03:00:00PM -0800, Tony Lindgren wrote:
> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [140228 12:46]:
> > Hi Joerg, Tony,
> > 
> > This is an updated series of the OMAP IOMMU DT adaptation intended
> > for 3.15 merge window, addressing the comments from the v2 series.
> > This series is rebased onto 3.14-rc4, and the only change to bindings
> > is to drop the dma-window property.
> > 
> > The first 7 patches in the series are in drivers/iommu, with the first
> > 3 patches performing some cleanup. The DT bindings and adaptation are
> > done in patches 4 and 5.
> > 
> > Tony,
> > Patches 8 through 13 are in arch/arm/mach-omap2 layer, so I am guessing
> > these would have to go through your tree. Of these, patches 8 and 9 are
> > cleanup fixes to get OMAP3 IVA MMU working, patches 10 & 11 are fixes
> > required with DT-boot for OMAP3/4, patches 12 & 13 add the OMAP5 support.
> 
> Are patches 8 to 13 OK to apply separately from the iommu patches or
> do they need to wait for the iommu patches to get merged first?

Applied patches 1-7 to my arm/omap branch.

Tony, you can pull that branch into your tree if needed (when I pushed
it, which will happen today or tomorrow).


	Joerg
