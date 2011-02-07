From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 1/9] omap4: powerdomain: Add supported INACTIVE power state
Date: Mon, 7 Feb 2011 12:33:37 +0530
Message-ID: <9cb5f3c283cc93d27be0c727f6f3bafa@mail.gmail.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
 <1296813544-25170-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102061335400.7672@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53017 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752239Ab1BGHDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 02:03:39 -0500
Received: by mail-iw0-f173.google.com with SMTP id 10so4749452iwc.32
        for <linux-omap@vger.kernel.org>; Sun, 06 Feb 2011 23:03:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102061335400.7672@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, February 07, 2011 2:12 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; b-cousson@ti.com;
> rnayak@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 1/9] omap4: powerdomain: Add supported
> INACTIVE power state
>
> Hi
>
> On Fri, 4 Feb 2011, Santosh Shilimkar wrote:
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
> > This patch adds the support to allow power domain INACTIVE
> programming
> > which is supported on OMAP4.
> >
> > The powerdomain autogen script is updated accordingly.
>
> Continuing the discussion here:
>
>    http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg43509.html
>
> 1. It appears that the OMAP4 powerdomain ON-ACTIVE state is a new
> state
> for OMAP4, and does not exist as such on previous chips (unless the
> PRM_VOLTCTRL.AUTO_* bits are all disabled)
>
Actually it's not new state but more of convention change. ON-ACTIVE
is like ON in OMAP3.

> 2. It also appears that the OMAP4 powerdomain ON-INACTIVE state
> is equivalent to the OMAP3 powerdomain ON state (again, assuming
> that the
> PRM_VOLTCTRL.AUTO_SLEEP bit is set on OMAP3).
>
This is correct.

> Could you please comment on whether these statements are true or
> false?
>

Just to summarise my undertsnaing of this here.
On OMAP3 too, we had possibility of being in a one of the
Two state when programmed to PD ON state.
ON-ACTIVE or ON-INACTIVE. The PD status registers just
says INACTIVE or ON based on the clodomains states within PD.

On OMAP4, the difference is we do have a way to
program the PD state explicitly as ON or INACTIVE.

Regards,
Santosh
