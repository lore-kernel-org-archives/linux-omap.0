From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 0/5] Clockdomain split series
Date: Tue, 25 Jan 2011 12:51:46 +0530
Message-ID: <d1bf3b27cc09672b48b27b5c01ccb00e@mail.gmail.com>
References: <1295360860-26490-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1101250018460.25864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36698 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751384Ab1AYHVr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 02:21:47 -0500
Received: by mail-fx0-f54.google.com with SMTP id 16so5121522fxm.41
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 23:21:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101250018460.25864@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, January 25, 2011 12:51 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com; khilman@ti.com
> Subject: Re: [PATCH v2 0/5] Clockdomain split series
>
> Hi Rajendra,
>
> On Tue, 18 Jan 2011, Rajendra Nayak wrote:
>
> > This patch series is an effort to split the clockdomain
> > framework into platform independent and platform specific parts
> > as was done for the powerdomain framework.
> >
> > This certainlly helps remove the various cpu_is_* checks
> > which exist today in the framework and makes
> > the code more maintainable and readable.
> >
> > The series is boot tested on OMAP2430/3430/4430SDP platforms.
> > Also on OMAP3430SDP, OFF mode in suspend path is validated
> > using the omap3_pm_defconfig.
> >
> > This series is based on latest mainline kernel and
> > can be found here
> > git://gitorious.org/omap-pm/linux.git clockdomain-split-v2
>
> Thanks.  I've queued these five patches, along with your powerdomain
> trivial header file removal fix, for 2.6.39.  They are in the
> 'pwrdm_clkdm_a_2.6.39' branch of git://git.pwsan.com/linux-2.6 - the
> branch is currently based on v2.6.38-rc2.

Thanks Paul.

>
>
> - Paul
