From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/10] arch/arm OMAP IOMMU patches for 3.15
Date: Wed, 12 Mar 2014 10:04:25 -0700
Message-ID: <20140312170424.GA30897@atomide.com>
References: <1394065459-16409-1-git-send-email-s-anna@ti.com>
	<531F84D6.8070101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <531F84D6.8070101-l0cyMroinI0@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [140311 14:52]:
> Hi Paul,
> 
> On 03/05/2014 06:24 PM, Suman Anna wrote:
> >Hi Paul, Benoit,
> >
> >This is a repost as per Tony's request [3] of all the OMAP IOMMU DT support
> >patches that are under arch/arm. The series just assimilates patches 8
> >through 13 from the v3 OMAP IOMMU DT adaptation for 3.15 series [1], and
> >all the v2 patches from the OMAP IOMMU DTS nodes [2].
> >
> >The only change made with respect to the patches above is in the OMAP4
> >and OMAP5 DTS nodes - I have adjusted the reg sizes from 0xff to 0x100.
> >
> >Can you please provide your acks on the hwmod patches and DTS
> >patches?
> 
> Ping. Can you review and provide your acks for Patches 2 and 5 (the
> hwmod patches) for Tony to pick up all the patches in the series?

Applied all with Paul's acks into omap-for-v3.15/dt. As it's getting
so late to the merge window, no guarantees it will actually get
pulled.

For the pdata-quirks.c changes, I assume you are working on
implementing the reset driver mentioned in the related patch?

Regards,

Tony
