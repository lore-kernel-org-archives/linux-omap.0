From: Olof Johansson <olof@lixom.net>
Subject: Re: [FAILURE] omap4430-sdp allnoconfig
Date: Fri, 2 Aug 2013 13:50:37 -0700
Message-ID: <CAOesGMhs2osur+VixuyknEWDNy9ekp=yY_6J40W_qRN1TsFWBA@mail.gmail.com>
References: <20130801175214.GA23053@n2100.arm.linux.org.uk>
	<51FAA4C6.10203@ti.com>
	<20130801182707.GB23053@n2100.arm.linux.org.uk>
	<51FAA985.3000809@ti.com>
	<51FAAA31.6020903@codeaurora.org>
	<51FAAAFD.6000706@codeaurora.org>
	<51FAAD73.3030103@ti.com>
	<20130801185956.GK8868@codeaurora.org>
	<20130801200618.GA8892@quad.lixom.net>
	<20130802204417.GA8296@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:47090 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab3HBUui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 16:50:38 -0400
Received: by mail-qe0-f53.google.com with SMTP id f6so615756qej.40
        for <linux-omap@vger.kernel.org>; Fri, 02 Aug 2013 13:50:38 -0700 (PDT)
In-Reply-To: <20130802204417.GA8296@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "arm@kernel.org" <arm@kernel.org>

On Fri, Aug 2, 2013 at 1:44 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/01, Olof Johansson wrote:
>> On Thu, Aug 01, 2013 at 11:59:56AM -0700, Stephen Boyd wrote:
>> > On 08/01, Santosh Shilimkar wrote:
>> > > This one looks fine for me. Can you send above in
>> > > a proper patch ? Let me know if you want me to
>> > > send it.
>> > >
>> >
>> > Here's a proper patch. Olof, can you please apply this on top of
>> > the merge (and maybe you can fix the merge again to handle the
>> > HAVE_CAN problem I mentioned earlier).
>> >
>> > ---8<---
>> > Subject: [PATCH] ARM: OMAP2+: Fix fallout from localtimer divorce and SMP=n
>> >
>> > A recent patch ef3160c (ARM: OMAP2+: Divorce from local timer
>> > API, 2013-03-04) broke the omap build when SMP=n because the TWD
>> > functions are only compiled on SMP=y builds. Stub out the TWD
>> > calls when the TWD isn't built in to to keep everything building.
>> >
>> > arch/arm/mach-omap2/built-in.o: In function
>> > `omap4_local_timer_init':
>> > dss-common.c:(.init.text+0x1d90): undefined reference to
>> > `twd_local_timer_register'
>> >
>> > Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>
>> Thanks, applied (with the reported-by changed as requested)
>>
>
> It looks like somehow you became the author. Is there anyway you
> can fix that and possibly fix the merge before it to not add
> HAVE_CAN_FLEXCAN if CAN in mach-imx/Kconfig?

That's because the patch wasn't sent such that it could be applied
with git am, and forgot to set authorship back. Fixed now.


-Olof
