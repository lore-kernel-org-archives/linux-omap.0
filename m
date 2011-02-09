From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Wed, 9 Feb 2011 15:30:36 +0530
Message-ID: <80a27c86473cf29a9fa5e68aa29eef46@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk><0557426516de482c1769a50fa0b5f17a@mail.gmail.com><20110208164747.GD6188@n2100.arm.linux.org.uk><78d0134576ace6be5874871076cf0c10@mail.gmail.com><alpine.LFD.2.00.1102081537010.14920@xanadu.home><20110209003537.GQ20795@atomide.com><54f225541194205f01fe9f03b5110d16@mail.gmail.com>
 <AANLkTin2zB32YVPZkr48gSOjm0N-WDnZFScysKC8ZTiv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:54559 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753463Ab1BIKA5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Feb 2011 05:00:57 -0500
Received: by wwj40 with SMTP id 40so7226445wwj.15
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 02:00:55 -0800 (PST)
In-Reply-To: <AANLkTin2zB32YVPZkr48gSOjm0N-WDnZFScysKC8ZTiv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Wednesday, February 09, 2011 3:18 PM
> To: Santosh Shilimkar
> Cc: Tony Lindgren; Nicolas Pitre; linux-omap@vger.kernel.org;
> Russell King - ARM Linux; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
>
> On Wed, Feb 9, 2011 at 6:04 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> >> Sent: Wednesday, February 09, 2011 6:06 AM
> >> To: Nicolas Pitre
> >> Cc: Santosh Shilimkar; Russell King - ARM Linux; linux-
> >> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >> Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
> >>
> >> * Nicolas Pitre <nico@fluxnic.net> [110208 12:41]:
> >> > On Tue, 8 Feb 2011, Santosh Shilimkar wrote:
> >> >
> >> > > > I think it's probably going to be better to _purposely_
> break
> >> the
> >> > > > OMAP build when it covers v6 and v7 CPUs in these kernels
> as I
> >> don't
> >> > > > think it's sanely fixable given where we are.
> >> >
> >> > Agreed. =A0At least making SMP unavailable when both v6 and v7
> are
> >> > configured should be small and good enough for 2.6.38-rc5.
> >>
> >> That's probably the best solution as then we can still do boot
> >> testing on all omap2plus_defconfig boards.
> >>
> > Just to be clear, are we saying disable SMP from omap2plus build.
> > If the v6, v7 is not fixable then, we also need a SMP
> > config for OMAP. Just boot test with SMP disable config for
> > OMAP4 is not enough.
>
> You could also have a "v7+" unified kernel -- i.e., supporting
> OMAP3+4+SMP.
> This is what we currently do in Linaro, since we're focusing on v7
> and above.
>
This sounds good way forward considering future OMAP architectures
as well.

But I let Tony comment on this idea.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
