From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHv3] OMAP3: SDRC : Add comments on Errata i520 for Global SW reset
Date: Wed, 22 Dec 2010 13:53:11 +0530
Message-ID: <f689bb3a487cd0df148a70449cc9ded5@mail.gmail.com>
References: <1286287534-9160-1-git-send-email-vishwanath.bs@ti.com> <alpine.DEB.2.00.1010050917080.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35415 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752164Ab0LVIXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 03:23:13 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so5624228fxm.17
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 00:23:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1010050917080.13816@utopia.booyaka.com>
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
