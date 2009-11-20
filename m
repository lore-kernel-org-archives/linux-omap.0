From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: FEATURES - is it good enough (was Re: [PATCH v3 1/2] omap:
 introduce uart_no_empty_fifo_read feature)
Date: Fri, 20 Nov 2009 22:36:54 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BBC43A27@dbde02.ent.ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
 <1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
 <4B06BF4D.2090201@ti.com>
 <A24693684029E5489D1D202277BE89444DA61E77@dlee02.ent.ti.com>
 <4B06C0F0.7070007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376AbZKTRGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 12:06:54 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKH6vf0015833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 11:07:00 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAKH6v2X010473
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 22:36:57 +0530 (IST)
In-Reply-To: <4B06C0F0.7070007@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Started reading threads today....

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Friday, November 20, 2009 9:47 PM
> To: Aguirre, Sergio
> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> Subject: FEATURES - is it good enough (was Re: [PATCH v3 1/2] omap:
> introduce uart_no_empty_fifo_read feature)
> 
> Aguirre, Sergio had written, on 11/20/2009 10:14 AM, the following:
> >
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Nishanth
> Menon
> >> Sent: Friday, November 20, 2009 10:10 AM
> >> To: Pandita, Vikram
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH v3 1/2] omap: introduce
> >> uart_no_empty_fifo_read feature
> >>
> >> Vikram Pandita had written, on 11/20/2009 10:02 AM, the
> following:
> >>> Interoduce omap feature OMAP3_HAS_UART_NO_EMPTY_FIFO_READ
> >>     ^^^^^^^^^ <- you meant introduce
> >>> On omap3630/omap4 an empty fifo read causes a crash
> >>>
> >>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >>> Ack-by: Menon, Nishanth <nm@ti.com>
> >>     ^^^^^ <- :P nope you dont have my Acked-by until you
> >> change this to
> >> Acked from Ack ;)..
> >>
> >> Thanks for the simpler patch.
> >>
> >>> ---
> >>>  arch/arm/mach-omap2/id.c              |    7 +++++++
> >>>  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
> >>>  2 files changed, 9 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> >>> index f48a4b2..3e266cd 100644
> >>> --- a/arch/arm/mach-omap2/id.c
> >>> +++ b/arch/arm/mach-omap2/id.c
> >>> @@ -176,6 +176,12 @@ void __init omap3_check_features(void)
> >>>  	OMAP3_CHECK_FEATURE(status, NEON);
> >>>  	OMAP3_CHECK_FEATURE(status, ISP);
> >>>
> >>> +	/* On omap3630 and omap4: UART empty rx fifo read aborts */
> >>> +	if (cpu_is_omap3630())
> >>> +		omap3_features |= OMAP3_HAS_UART_NO_EMPTY_FIFO_READ;
> >>> +	if (cpu_is_omap44xx())
> >>> +		omap3_features |= OMAP3_HAS_UART_NO_EMPTY_FIFO_READ;
> >>> +
> >
> > Probably not something ot be attached in this patch, but...
> >
> > I'm a bit curious about something:
> >
> > Why touching omap3_features in OMAP4?
> >
> > Isn't there a omap4_features?
> >
> > Or even better, an omap_features?

This "is_feature" suppose to take care of Errata's also, is it?
This is errata more than a feature..... We better differentiate in this regard

Regards,
Santosh
