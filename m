From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1
Date: Thu, 10 Mar 2011 20:07:24 +0530
Message-ID: <3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com> <alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:53413 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869Ab1CJOh1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:37:27 -0500
Received: by mail-qy0-f169.google.com with SMTP id 2so4895723qyk.7
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 06:37:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

Paul, Benoit,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Thursday, March 10, 2011 2:15 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Rajendra Nayak; Beno=EEt Cousson
> Subject: Re: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle
> for GPT1
>
> On Wed, 9 Mar 2011, Paul Walmsley wrote:
>
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> > Some issues seen (which cause lockups in suspend) with GPT1
> > after the MPU<->L4_WKUP static dependency was cleared can be
> > Worked-around for now by forcing GPT1 in software
> > controlled idle.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Beno=EEt Cousson <b-cousson@ti.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
>
> Just a quick note, I missed Beno=EEt's update of the commit message:
>
>     http://www.spinics.net/linux/lists/linux-omap/msg48008.html
>
> and he's the maintainer of this so we should use his instead.  The
> revised
> message is below.
>

We continued further debug on the static dependency issues with
OMAP4 PM series.
So far from the findings what I have, this timer patch is actually not
needed and can be dropped. Infact the patch is not really effective
because current timer driver(not hwmod adapted yet) puts timer1
in smart idle again.

There is another static dep. just like MPUSS<-->EMIF seems to create
an issue. The lock-up is not very consistently reproducible so it's
very easy to get miss-leading results. Timer patch was one of those
observations. With or without timer patch I can reproduce the hang
with long duration test.

Will keep narrowing down the next offending static dependency but
in mean time I suggest you to drop this patch.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
