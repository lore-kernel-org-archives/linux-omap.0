From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 14/16] ARM: OMAP3: hwmod data: cleanup data for IOMMUs
Date: Thu, 27 Feb 2014 16:25:03 -0800
Message-ID: <20140228002502.GB14514@atomide.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
	<1392315347-32967-15-git-send-email-s-anna@ti.com>
	<20140226171824.GH11654@atomide.com> <530E2B67.9050300@ti.com>
	<530F0255.0@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <530F0255.0-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org> [140227 01:19]:
> Hi,
> 
> On 02/26/2014 06:59 PM, Suman Anna wrote:
> > Tony,
> > 
> > On 02/26/2014 11:18 AM, Tony Lindgren wrote:
> >> * Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [140213 10:19]:
> >>> From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> >>>
> >>> The irq numbers, ocp address space and device attribute data
> >>> have all been cleaned up for OMAP3 IOMMUs. All this data is
> >>> populated via the corresponding dt node.
> >>>
> >>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> >>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> >>
> >> This will need to wait until we've made omap3 to be DT only
> >> as this will break idling of things for the legacy booting.
> >>
> > 
> > OK, will drop this and I will adjust Patch 9 to support the legacy boot
> > for OMAP3 ISP.
> > 
> 
> BTW, Tony do you have a new window for omap3 to be DT onyl?

I think a good point would be when we have DSS working with DT,
and have a .dts file for the Pandora board.

Regards,

Tony
