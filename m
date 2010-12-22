From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHv3] OMAP3: SDRC : Add comments on Errata i520 for Global SW reset
Date: Wed, 22 Dec 2010 13:54:39 +0530
Message-ID: <aac126948aa3aea0421e82c814e1e57b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48641 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752164Ab0LVIYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 03:24:42 -0500
Received: by fxm20 with SMTP id 20so4960429fxm.33
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 00:24:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul,

Do you intend to merge this patch for 2.6.38? I did not see this in your
pull request.

Vishwa

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, October 05, 2010 8:48 PM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org; Premi, Sanjeev
> Subject: Re: [PATCHv3] OMAP3: SDRC : Add comments on Errata i520
> for Global SW reset
>
> On Tue, 5 Oct 2010, Vishwanath BS wrote:
>
> > This patch adds comments on precatution to be taken if Global Warm
> reset is
> > used as the means to trigger sysem reset.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
>
> Thanks, queued for 2.6.38 with Sanjeev's spelling fix.
>
>
> - Paul
