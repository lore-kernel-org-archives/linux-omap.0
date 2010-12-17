From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
Date: Fri, 17 Dec 2010 15:50:59 +0530
Message-ID: <e2e2e2d15f146b8ab9f973335f6da14e@mail.gmail.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com><f3afb9340d4f1d0c8d2936d9faea79c8@mail.gmail.com>
 <AANLkTi=968TjtNn_M5FV54xF-E8Xw=3xohN0g+iJZ04Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41562 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753669Ab0LQKVB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 05:21:01 -0500
Received: by mail-gx0-f176.google.com with SMTP id 4so266646gxk.21
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:21:00 -0800 (PST)
In-Reply-To: <AANLkTi=968TjtNn_M5FV54xF-E8Xw=3xohN0g+iJZ04Z@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Friday, December 17, 2010 3:48 PM
> To: Santosh Shilimkar; khilman@deeprootsystems.com
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
Jean
> Pihet-XID
> Subject: Re: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
>
> Hi Santosh, Kevin,
>
> On Fri, Dec 17, 2010 at 6:05 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > Jean,
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> >> Sent: Thursday, December 16, 2010 11:21 PM
> >> To: linux-omap@vger.kernel.org
> >> Cc: khilman@deeprootsystems.com;
linux-arm-kernel@lists.infradead.org;
> >> Jean Pihet
> >> Subject: [PATCH 0/7 v4] OMAP3: clean up ASM sleep code
> >>
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> This patch only contains clean-ups and cosmetic changes,
> >> no functional change.
> >>
> >> Clean-up of the ASM sleep code, for better readability and
> >> easier maintenance.
> >>
> >> Applies on top of Nishant's latest idle path errata fixes step 2,
> >> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
> >>
> > Thanks for cleanup. Have few minor comments on these patches.
>
> Thanks for the review.
> I fixed the issues and reposted the series as '[PATCH 0/7 v5] OMAP3:
> clean up ASM sleep code'.
>
Thanks. I checked it. Will ack your patches
