From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3 00/13] OMAP IOMMU DT adaptation for 3.15
Date: Wed, 5 Mar 2014 11:33:26 -0800
Message-ID: <20140305193326.GA7599@atomide.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
	<20140228230000.GW13624@atomide.com>
	<20140304160432.GG2799@8bytes.org> <5316068F.3020003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5316068F.3020003-l0cyMroinI0@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [140304 09:03]:
> On 03/04/2014 10:04 AM, Joerg Roedel wrote:
> >
> >Applied patches 1-7 to my arm/omap branch.
> >
> >Tony, you can pull that branch into your tree if needed (when I pushed
> >it, which will happen today or tomorrow).

OK thanks, looks like remaining patches compile just fine even without
it which is nice.

> Tony,
> Can you also pull in the corresponding DTS node patches as well that
> go along with this series.
> http://marc.info/?l=linux-omap&m=139362062805816&w=2

They look OK to me, but looks like Benoit and Paul are not Cc:ed
on the hwmod changes. I suggest you resend just patches 8 - 13 and
the .dts changes as a new series with Benoit and Paul on Cc for
them so they have a chance to review and ack them.

Regards,

Tony
