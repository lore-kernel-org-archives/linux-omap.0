From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Sat, 20 Nov 2010 15:26:42 +0530
Message-ID: <414b757858278de2048cf851f96e541e@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com> <877hg92ep4.fsf@deeprootsystems.com>
 <4CE6EE0B.1090809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38253 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761Ab0KTJ4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Nov 2010 04:56:47 -0500
Received: by vws6 with SMTP id 6so567520vws.6
        for <linux-omap@vger.kernel.org>; Sat, 20 Nov 2010 01:56:46 -0800 (PST)
In-Reply-To: <4CE6EE0B.1090809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Saturday, November 20, 2010 3:07 AM
> To: Kevin Hilman
> Cc: linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
> Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
>
> Kevin Hilman had written, on 11/19/2010 03:20 PM, the following:
>
> >> Request for testing this series for comparison between master and
this
> >> series requested for additional platforms where available.
> >
> > I haven't yet been through the entire series, but some general
comments
> > to share before the weekend:
> thanks for comments so far. I will wait for the complete series to be
> reviewed before reposting a v2.
>
> >
> > The secure mode code is growing in size and complexity, so I think it
> > should be removed from pm34xx.c and moved into it's own file
> > (secure3xxx.c ?)   This will help keep pm34xx.c lean, and it can call
> > into secure code as needed.

We already have omap44xx-smc.S. I could make this generic. One problem
with
The secure APIs, they are consistent in all OMAP version. For example
Secure
SAR save has a different API and signature on OMAP3 and OMAP4.
But this is something doable.

Regards,
Santosh
