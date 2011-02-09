From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Wed, 9 Feb 2011 21:57:43 +0530
Message-ID: <d655d7259563a3bb47fd877c66b0269f@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <0557426516de482c1769a50fa0b5f17a@mail.gmail.com> <20110208164747.GD6188@n2100.arm.linux.org.uk>
 <78d0134576ace6be5874871076cf0c10@mail.gmail.com> <alpine.LFD.2.00.1102081537010.14920@xanadu.home>
 <20110209003537.GQ20795@atomide.com> <54f225541194205f01fe9f03b5110d16@mail.gmail.com>
 <AANLkTin2zB32YVPZkr48gSOjm0N-WDnZFScysKC8ZTiv@mail.gmail.com>
 <80a27c86473cf29a9fa5e68aa29eef46@mail.gmail.com> <20110209162421.GU20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:44128 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752595Ab1BIQ2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 11:28:01 -0500
Received: by mail-ww0-f46.google.com with SMTP id 40so344127wwj.3
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 08:28:00 -0800 (PST)
In-Reply-To: <20110209162421.GU20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, February 09, 2011 9:54 PM
> To: Santosh Shilimkar
> Cc: Dave Martin; Nicolas Pitre; linux-omap@vger.kernel.org; Russell
> King - ARM Linux; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110209 01:59]:
> > > From: Dave Martin [mailto:dave.martin@linaro.org]
> > >
> > > You could also have a "v7+" unified kernel -- i.e., supporting
> > > OMAP3+4+SMP.
> > > This is what we currently do in Linaro, since we're focusing on
> v7
> > > and above.
> > >
> > This sounds good way forward considering future OMAP architectures
> > as well.
> >
> > But I let Tony comment on this idea.
>
> AFAIK these issues will be hopefully sorted out by the time the
> next merge window opens. For the -rc cycle, disabling SMP in
> config if ARMv6 is selected should do the trick.
>
Ok.

Regards,
Santosh
