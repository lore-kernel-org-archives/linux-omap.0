From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 7/7] omap4: dpll: Enable auto gate control for all MX postdividers
Date: Mon, 14 Feb 2011 18:04:46 +0530
Message-ID: <d91c419d34c18bc45915b50cefccaa9d@mail.gmail.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
 <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com>
 <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com> <1297329400-5936-7-git-send-email-rnayak@ti.com>
 <1297329400-5936-8-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102121809360.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55082 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753831Ab1BNMfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 07:35:48 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so5753713fxm.40
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 04:35:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102121809360.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Sunday, February 13, 2011 6:41 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com; khilman@ti.com;
santosh.shilimkar@ti.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v2 7/7] omap4: dpll: Enable auto gate control for
all MX postdividers
>
> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
>
> > Enable hardware gate control for all dpll MX and X2 postdividers.
> > This requires the allow_idle/deny_idle functions to be
> > populated for all clock nodes (mx/x2 post dividers) in
> > clkops.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> Thanks, queued for 2.6.39 in the 'clk_autoidle_a_2.6.39' branch.  Has
the
> OMAP4 clock data autogenerator script been updated?

Yes, the autogen scripts are updated. Will merge the changes
in master.

Regards,
Rajendra
>
>
> - Paul
