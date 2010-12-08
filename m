From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi() forCONFIG_THUMB2_KERNEL
Date: Wed, 8 Dec 2010 11:27:12 +0530
Message-ID: <2080abb418a8d3c651dd41353ef59d25@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org><1291656937-24992-3-git-send-email-dave.martin@linaro.org><a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
 <AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33091 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752124Ab0LHF5O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 00:57:14 -0500
Received: by pwi10 with SMTP id 10so214602pwi.13
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 21:57:14 -0800 (PST)
In-Reply-To: <AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Tuesday, December 07, 2010 10:21 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; Tony Lindgren; linux-
> omap@vger.kernel.org; linaro-dev@lists.linaro.org
> Subject: Re: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
> forCONFIG_THUMB2_KERNEL
>
> Hi,
>
> On Tue, Dec 7, 2010 at 6:28 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > Dave,
> >> -----Original Message-----
> >> From: linaro-dev-bounces@lists.linaro.org [mailto:linaro-dev-
> >> bounces@lists.linaro.org] On Behalf Of Dave Martin
> >> Sent: Monday, December 06, 2010 11:06 PM
> >> To: linux-arm-kernel@lists.infradead.org
> >> Cc: Tony Lindgren; Dave Martin; linux-omap@vger.kernel.org; linaro-
> >> dev@lists.linaro.org
> >> Subject: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
> >> forCONFIG_THUMB2_KERNEL
> >>
> >> For the Thumb-2 case, the "wfi" mnemonic is used, since in this
> >> case the tools will necessarily be new enough to support it.
> >>
> >> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> >> ---
> >> KernelVersion: 2.6.37-rc4
> >
> > The choice of opcode instead of instruction here was not because
> > of toolchain. The problem was it breaks multi-omap build where
> > ARMv6 and ARMv7 are build together.
> >
> > For this reason I NAK this patch.
>
> You can't built a kernel for pre-v7 platforms with
> CONFIG_THUMB2_KERNEL: the code can't run on those platforms because
> they don't support Thumb-2.
>
That's better.

> So anything inside #ifdef CONFIG_THUMB2_KERNEL can assume v7/Thumb-2
> capable (and hence reasonably new) tools.
>
> I'll follow up shortly with a patch to the generic ARM Kconfig to make
> this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't accidentally
> be configured together.
>
sure
