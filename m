From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: DMA: Move plat/dma hearder to platform_data/dma-omap
Date: Fri, 28 Sep 2012 20:41:49 +0530
Message-ID: <CAMQu2gwL_zdCVp5ZXSjLq2+Pb7EsaiUQrtHbpFMgVAz5oycM5w@mail.gmail.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
 <1348839609-10456-3-git-send-email-lokeshvutla@ti.com> <20120928145459.GZ4840@atomide.com>
 <CAMQu2gw9DJSZ4QVvo83atTpnsXyegneuQ2rJKBc+5ioiwEaqaQ@mail.gmail.com> <20120928150538.GB4840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47455 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758438Ab2I1PMM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 11:12:12 -0400
Received: by vbbff1 with SMTP id ff1so3249225vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 08:12:10 -0700 (PDT)
In-Reply-To: <20120928150538.GB4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 28, 2012 at 8:35 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120928 08:02]:
>> On Fri, Sep 28, 2012 at 8:25 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > * Lokesh Vutla <lokeshvutla@ti.com> [120928 06:41]:
>> > > Move plat/dma.h header to platform_data/dma-omap.h as
>> > > part of the single zImage work.
>> >
>> > Hmm there's no platform data in this header, just
>> > exported things for drivers to use. So it should not
>> > be placed into platform_data.
>> >
>> > Maybe it should be #include <asm/mach/dma-omap.h> for now?
>> >
>> I wasn't sure either when the file was placed under platform-data.
>> I agree for now we can keep it mach layer but than means OMAP1 and
>> OMAP2+ DMA header and source code needs to be split. That
>> is not so straight forward.
>
> No need for that, the path I'm suggesting is located under
> arch/arm/include/asm/mach, it's not same as include <mach/dma-omap.h>.
>
That sound ok.

>> With DMA engine conversion hopefully, we might get rid of the
>> header eventually, but for now not sure whether we should
>> go ahead and follow the splitting part.
>>
>> Thoughts ?
>
> No need for splitting anything :)
>
> The other possible location would be just include <linux/dma-omap.h>,
> but as we all know that will be going away, <asm/mach/dma-omap.h>
> is probably better.
>
Agree. I missed the "arch/arm/include/asm/mach" path.
Thanks.

Regards
Santosh
