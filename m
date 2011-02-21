From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: OMAP4: IRQ line of CortexA9 performance monitor
Date: Mon, 21 Feb 2011 23:23:43 +0530
Message-ID: <e96b735de3303ad461e00ccc0ef61b8f@mail.gmail.com>
References: <AANLkTin3q+rv+fcgCE6nwTN+=v_uQzT-Sn++gr6ekXcp@mail.gmail.com> <yw1x62sd1f26.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:35779 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720Ab1BUR7y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 12:59:54 -0500
Received: by mail-qw0-f52.google.com with SMTP id 6so1153623qwf.25
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 09:59:53 -0800 (PST)
In-Reply-To: <yw1x62sd1f26.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of M=E5ns Rullg=E5rd
> Sent: Monday, February 21, 2011 10:49 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Subject: Re: OMAP4: IRQ line of CortexA9 performance monitor
>
> Ming Lei <tom.leiming@gmail.com> writes:
>
> > Hi,
> >
> > From chapter 17 of "Interrupt controller", OMAP4 TRM, I can't
> > find what is the interrupt line of CortexA9 performance monitor
> > in omap4. Seems without this information, we can't use perf on
> > omap4.
> >
> > Any suggestions or ideas about it?
>
> The PMU interrupt is routed through the CTI, which needs to be
> properly
> configured.  Unfortunately, the CTI is not documented in the public
> TRM,
> and nobody has seen fit to submit a patch suitable for upstream.
> Some dirty hacks have been posted, though.
>
Mans is right. Last time I looked at this, the OMAP4 PMU support
needed some hacky code and was not fitting to the generic PMU
framework.

I will take a second look at it and see if a patch can be generated
for upstream.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
