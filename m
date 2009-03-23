From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3 clock: Access only available clock bits
Date: Mon, 23 Mar 2009 10:23:31 +0900
Message-ID: <4d34a0a70903221823o40bcc347y433447664571c2c6@mail.gmail.com>
References: <4d34a0a70903192015j4ea44b1fn4f7bb045da32d218@mail.gmail.com>
	<alpine.DEB.2.00.0903201523220.4676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:44117 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZCWBXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Mar 2009 21:23:51 -0400
Received: by gxk7 with SMTP id 7so1925822gxk.13
        for <linux-omap@vger.kernel.org>; Sun, 22 Mar 2009 18:23:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0903201523220.4676@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, kyungmin.park@samsung.com, Tony Lindgren <tony@atomide.com>, bhmin@samsung.com

Hi Paul,

On Sat, Mar 21, 2009 at 6:48 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Kyuwon,
>
> On Fri, 20 Mar 2009, Kim Kyuwon wrote:
>
>> I found a problem on PM Branch with OMAP3430 ES3.1 Board when enabling
>> OMAP_RESET_CLOCKS feature.
>> In clk_disable_unsed() function, as soon as sad2d_ick is disabled,
>> prcm interrupt is generated and its handler can't exit loop at next
>> statement!
>>
>> while (prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET));
>
> We encountered a similar problem a few months ago.  The problem is
> probably the pad mux settings on the d2d_mstdby and d2d_swakeup pads.
> These are usually configured by the bootloader.  My recollection is that
> they should be pulled up, but I don't recall for sure.  Yes, we should
> have a patch in the PM branch to at least detect whether these pads are
> configured incorrectly...

Thank you for letting me know the better solution. I confirmed that
this problem can be fixed by configuring the d2d_mstdby and
d2d_swakeup pads. (As you said, swakeup -> pulled down & mstdby ->
pulled up.)

>> I also found that sad2d_ick is available only OMAP3430 ES1. I fixed
>> this problem with below patch.
>
> Thanks for your patch, but, sad2d_ick is indeed present on ES2+. TI
> removed the documenation from the main TRM and moved it to the "OMAP34xx
> Stacked Mode Addendum" (SWCU048).  Ill-advised, in my opinion!
>

I have only the "OMAP34xx ES3.0 Stacked Mode Addendum" and I can see
EN_SAD2D is available in this document. ES3.1 is maybe same.
I think this patch is not needed anymore. Thank you so much for your help!

Regards,
Kyuwon
