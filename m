From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined reference'
Date: Wed, 5 Jan 2011 00:20:02 +0530
Message-ID: <d7800f7a785b294a089ea8772607d232@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
 <4D236AFB.2050301@ti.com> <2a7055e7c506648a2a48a0454756687b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:36980 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129Ab1ADSuE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:50:04 -0500
Received: by yie19 with SMTP id 19so3632780yie.3
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:50:03 -0800 (PST)
In-Reply-To: <2a7055e7c506648a2a48a0454756687b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Wednesday, January 05, 2011 12:18 AM
> To: Nishanth Menon
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org; Thara Gopinath; Kevin Hilman
> Subject: RE: [PATCH 4/5] omap2plus: voltage: Trivial linking fix
> 'undefined reference'
>
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Nishanth Menon
> > Sent: Wednesday, January 05, 2011 12:16 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
> > linux-arm-kernel@lists.infradead.org; Thara Gopinath; Kevin Hilman
> > Subject: Re: [PATCH 4/5] omap2plus: voltage: Trivial linking fix
> > 'undefined reference'
> >
> > Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the
> > following:
> > [..]
> >
[..]

> > > +static inline struct voltagedomain
> > *omap_voltage_domain_lookup(char *name)
> > > +{
> > > +	return NULL;
> > the omap_voltage_domain_lookup uses ERR_PTR() for all return
> values
> > which are handled by the callers with IS_ERR()
> >
> > I think you should return ERR_PTR(-EINVAL)
> >
> The expected return value is pointer type and hence used
> NULL.

'ERR_PTR(-EINVAL)' is also ok.
