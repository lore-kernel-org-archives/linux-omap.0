From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power state
Date: Tue, 1 Feb 2011 11:59:25 +0530
Message-ID: <30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
 <1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38049 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750849Ab1BAG32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 01:29:28 -0500
Received: by mail-gx0-f169.google.com with SMTP id 5so2972657gxk.0
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 22:29:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 01, 2011 4:44 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; b-cousson@ti.com;
> rnayak@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE
> power state
>
> Hello Santosh,
>
> On Fri, 28 Jan 2011, Santosh Shilimkar wrote:
>
> > On OMAP4, one can explicitly program INACTIVE as the power state
> of
> > the logic area inside the power domain. Techincally PD state
> programmed
> > to ON and if all the clock domains within the PD are idled, is
> equivalent
> > tp PD programmed to INACTIVE and all the clock domains within the
> PD are
> > idled. There won't be any power difference in above two.
> >
> > Since the CPUIDLE C-states explicitly make use of INACTIVE as a PD
> > targeted state and also there is some additional latancy involved
> > with PD INACTIVE vs PD ON, it's better to support it as an explcit
> > PD state.
> >
> > This patch adds the support to allow explicit PD INACTIVE
> > programming if supported.
>
> What does the hardware do when the powerdomain is programmed to
> INACTIVE?
> Does it actually force the clockdomains idle?
>
No. It doesn't force it. The power domain to hit INACTIVE, the
clockdomain within the power domain needs to idle and it is
still a prerequisite. With INACTIVE being programmed, we could
issue a sleep transition.

PD_ON:
No power transition, only clocks are gated. Power domain stays ON.

PD_INA:
Power domain transitions to INACTIVE state. All logic and
memory stay powered. This state allows for a voltage
sleep transition.

Regards,
Santosh
