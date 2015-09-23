From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: Add support for configuring dsp iommus
	on DRA7xx
Date: Wed, 23 Sep 2015 10:53:49 -0700
Message-ID: <20150923175348.GJ23801@atomide.com>
References: <1437522936-19758-1-git-send-email-s-anna@ti.com>
	<1437522936-19758-3-git-send-email-s-anna@ti.com>
	<20150722052600.GF17550@atomide.com> <55AFC34E.4000603@ti.com>
	<20150723072455.GC16878@atomide.com> <55B114DF.8070800@ti.com>
	<20150724043056.GG16878@atomide.com> <55B266CE.9070202@ti.com>
	<20150728061426.GL16878@atomide.com> <55E8D077.3050108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55E8D077.3050108-l0cyMroinI0@public.gmane.org>
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
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [150903 16:01]:
> >>>> On 07/23/2015 02:24 AM, Tony Lindgren wrote:
> > OK maybe check the syss/sysc registers involved here for each hardware
> > module here and which driver tinkers with which registers? This will
> > make things a lot easier in the long run for sure.
> 
> The OMAP remoteproc driver typically deals with only the reset registers
> and another register in the Control module for programming the boot
> address for the DSPs. You can look up the OMAP4 hwmod data for
> reference. There is currently a .prcm.omap4.modulemode set for these,
> and I have a patch to remove those. I haven't yet posted it yet [1],
> because OMAP remoteprocs are still not bootable on mainline.

Thanks for checking that. Like we chatted, let's make sure we don't
end up with iommu and remoteproc "consumer device" specific data
in the iommu and remoteproc code.

Regards,

Tony

> [1]
> http://git.ti.com/gitweb/?p=rpmsg/remoteproc.git;a=commit;h=0dd2a6a2d8869ee6cec92f75d70663259a41c11f
