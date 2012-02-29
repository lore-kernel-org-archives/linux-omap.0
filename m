From: Jingoo Han <jg1.han@samsung.com>
Subject: RE: [GIT PULL] OMAP DSS fixes for 3.3-rc
Date: Wed, 29 Feb 2012 10:42:35 +0900
Message-ID: <005a01ccf683$6964e3b0$3c2eab10$%han@samsung.com>
References: <1329988974.1820.62.camel@deskari> <4F4CFAD1.1000301@gmx.de>
 <1330445287.2123.236.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11234 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab2B2Bmi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 20:42:38 -0500
In-reply-to: <1330445287.2123.236.camel@deskari>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, 'linux-omap mailing list' <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-owner@vger.kernel.org] On Behalf Of Tomi
> Valkeinen
> Sent: Wednesday, February 29, 2012 1:08 AM
> To: Florian Tobias Schandinat
> Cc: linux-fbdev@vger.kernel.org; linux-omap mailing list
> Subject: Re: [GIT PULL] OMAP DSS fixes for 3.3-rc
> 
> On Tue, 2012-02-28 at 16:03 +0000, Florian Tobias Schandinat wrote:
> > On 02/23/2012 09:22 AM, Tomi Valkeinen wrote:
> > > Hi Florian,
> > >
> > > Two fixes for OMAP DSS for 3.3:
> > >
> > > First one gets the HDMI output working again. Managing the clocks for
> > > OMAP4 is not very simple, and this patch circumvents the problems we
> > > have in the clock framework. It's a clean but rather hacky fix, but it
> > > shouldn't cause any side-effects. The issue will hopefully be fixed
> > > properly with DT when we'll get proper parent-child hierarchy for DSS HW
> > > submodules.
> > >
> > > The second one is a simple fix for HDMI hotplug detection, which I
> > > missed when I wrote the HDMI PHY fix
> > > (c49d005b6cc8491fad5b24f82805be2d6bcbd3dd).
> >
> > Merged. You would add
> > Cc: stable@vger.kernel.org
> > to patches if appropriate?
> 
> Thanks. Yes, I have sent a separate mail to stable list, as the patches
> needed some tuning to apply.

Tomi, sorry.
You have already sent a mail to stable@vger.kernel.org.
Good luck.

Best regards,
Jingoo Han
> 
>  Tomi

