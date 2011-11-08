From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL v3] ARM: OMAP: Cortex-A9 PERIPHCLK node for 3.2
Date: Tue, 8 Nov 2011 13:37:34 +0530
Message-ID: <CAMQu2gwAezM7WZRyZFijYf0vLGEWRaUOGkyctBp=9A5+7oV=tA@mail.gmail.com>
References: <alpine.DEB.2.00.1110101342010.5205@utopia.booyaka.com>
 <alpine.DEB.2.00.1110101415560.5205@utopia.booyaka.com> <alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com>
 <20111105005312.GQ31337@atomide.com> <alpine.DEB.2.00.1111080051471.12394@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:37784 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753177Ab1KHIH5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Nov 2011 03:07:57 -0500
Received: by mail-qw0-f44.google.com with SMTP id c10so104587qad.10
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 00:07:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1111080051471.12394@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, keshava_mgowda@ti.com

On Tue, Nov 8, 2011 at 1:23 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Fri, 4 Nov 2011, Tony Lindgren wrote:
>
>> * Paul Walmsley <paul@pwsan.com> [111010 17:09]:
>> > The following changes since commit be73246058737beec52ae232bcab777=
6332a9e06:
>> >
>> > =A0 ARM: OMAP2+: Remove custom init_irq for remaining boards (2011=
-09-26 17:50:37 -0700)
>> >
>> > are available in the git repository at:
>> > =A0 git://git.pwsan.com/linux-2.6 clock_hwmod_devel_3.2
>> >
>> > This pull request drops the EHCI/OHCI hwmod data due to some
>> > inconsistencies that were just found in the data.
>> >
>> > Santosh Shilimkar (1):
>> > =A0 =A0 =A0 ARM: OMAP4: clock: Add CPU local timer clock node.
>> >
>> > =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A09 +++++++++
>> > =A01 files changed, 9 insertions(+), 0 deletions(-)
>>
>> Should this be pulled into fixes for v3.2 -rc cycle?
>
> Santosh would be the right person to ask. =A0Santosh, is anything bro=
ken in
> 3.2 if this patch doesn't get merged in -rc? =A0Or is it just a featu=
re
> which could be added in 3.3?
>
Nope nothing broken now since OMAP CPUFreq has not
got into mainline yet. We need this patch to present once we
start supporting MPU frequency scaling which I guess would
happen now in 3.3.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
