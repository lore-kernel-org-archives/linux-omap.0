From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power state
Date: Thu, 3 Feb 2011 14:25:39 +0530
Message-ID: <6552cf1963f333b1ddba0b9bbd5acb22@mail.gmail.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
 <1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com> <30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
 <alpine.DEB.2.00.1102021430460.7672@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45108 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754767Ab1BCIzo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 03:55:44 -0500
Received: by mail-yw0-f46.google.com with SMTP id 7so112538ywo.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 00:55:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102021430460.7672@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, February 03, 2011 3:11 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Benoit Cousson;
> Rajendra Nayak; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE
> power state
>
> On Tue, 1 Feb 2011, Santosh Shilimkar wrote:
>
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Tuesday, February 01, 2011 4:44 AM
> > >
> > > What does the hardware do when the powerdomain is programmed to
> > > INACTIVE?
> > > Does it actually force the clockdomains idle?
> >
> > No. It doesn't force it. The power domain to hit INACTIVE, the
> > clockdomain within the power domain needs to idle and it is
> > still a prerequisite. With INACTIVE being programmed, we could
> > issue a sleep transition.
> >
> > PD_ON:
> > No power transition, only clocks are gated. Power domain stays ON.
> >
> > PD_INA:
> > Power domain transitions to INACTIVE state. All logic and
> > memory stay powered. This state allows for a voltage
> > sleep transition.
>
> Okay.  So programming an OMAP4 powerdomain to INACTIVE is equivalent
> to
> programming an OMAP3 powerdomain to ON with the
> PRM_VOLTCTRL.AUTO_SLEEP
> bit to 1?
>
> Are there any other dependencies with the
> PRM_VOLTCTRL_AUTO_CTRL_VDD*
> registers, e.g., does the appropriate VDD bitfield there need to be
> set to
> 0x1 also to allow the sleep transition to occur?
>
If we plan to do sleep transions, then DEVICE PRM needs to be
programmed for voltage level and the control bit enable.

Regards,
Santosh
