From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support for
 all DPLL's
Date: Mon, 14 Feb 2011 17:59:21 +0530
Message-ID: <813a909da6bafa7ce0c15fa77d9d25b9@mail.gmail.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
 <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com>
 <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56641 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754013Ab1BNM33 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 07:29:29 -0500
Received: by mail-fx0-f51.google.com with SMTP id 5so5061407fxm.38
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 04:29:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Sunday, February 13, 2011 5:58 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com; khilman@ti.com;
santosh.shilimkar@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support
for all DPLL's
>
> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
>
> > All OMAP3/4 dpll's support hardware level autogating.
> > Populate allow_idle/deny_idle function pointers for all
> > DPLL's in clkops.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> Thanks, queued for 2.6.39.  Two questions though.  Was the OMAP4
> autogeneration script updated?  Also, any technical reason why you
didn't
> add the OMAP2 DPLL?

Yes, the autogen scripts are updated, however they are
currently in a separate branch (dpll-gatectrl).
Will merge them into master soon.

No real reason for not adding OMAP2 dpll autoidle support.
Its just that I started off trying to do this for OMAP4, and
then found me touching some omap3 stuff and hence
also did it for OMAP3.(For some reason I thought there
were no DPLL's in OMAP2).

Regards,
Rajendra

>
>
> - Paul
