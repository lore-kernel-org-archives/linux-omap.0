From: Jingoo Han <jg1.han@samsung.com>
Subject: RE: [GIT PULL] OMAP DSS fixes for 3.3-rc
Date: Wed, 29 Feb 2012 10:18:08 +0900
Message-ID: <004b01ccf67f$ff175360$fd45fa20$%han@samsung.com>
References: <1329988974.1820.62.camel@deskari> <4F4CFAD1.1000301@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46249 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab2B2BSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 20:18:10 -0500
In-reply-to: <4F4CFAD1.1000301@gmx.de>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, 'linux-omap mailing list' <linux-omap@vger.kernel.org>

Hi.
> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-owner@vger.kernel.org] On Behalf Of Florian
> Tobias Schandinat
> Sent: Wednesday, February 29, 2012 1:03 AM
> To: Tomi Valkeinen
> Cc: linux-fbdev@vger.kernel.org; linux-omap mailing list
> Subject: Re: [GIT PULL] OMAP DSS fixes for 3.3-rc
> 
> On 02/23/2012 09:22 AM, Tomi Valkeinen wrote:
> > Hi Florian,
> >
> > Two fixes for OMAP DSS for 3.3:
> >
> > First one gets the HDMI output working again. Managing the clocks for
> > OMAP4 is not very simple, and this patch circumvents the problems we
> > have in the clock framework. It's a clean but rather hacky fix, but it
> > shouldn't cause any side-effects. The issue will hopefully be fixed
> > properly with DT when we'll get proper parent-child hierarchy for DSS HW
> > submodules.
> >
> > The second one is a simple fix for HDMI hotplug detection, which I
> > missed when I wrote the HDMI PHY fix
> > (c49d005b6cc8491fad5b24f82805be2d6bcbd3dd).
> 
> Merged. You would add
> Cc: stable@vger.kernel.org
> to patches if appropriate?

I agree on Florian's opinion.
It would be good to add this patch to stable kernel. :)

> 
> 
> Thanks,
> 
> Florian Tobias Schandinat
> 
> >
> >  Tomi
> >
> > The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
> >
> >   Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)
> >
> > are available in the git repository at:
> >   git://gitorious.org/linux-omap-dss2/linux.git for-3.3-rc
> >
> > Archit Taneja (1):
> >       OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is enabled
> >
> > Rob Clark (1):
> >       OMAPDSS: HDMI: hot plug detect fix
> >
> >  drivers/video/omap2/dss/hdmi.c            |   24 +++++++++++++++++++++++-
> >  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +--------
> >  2 files changed, 24 insertions(+), 9 deletions(-)
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

