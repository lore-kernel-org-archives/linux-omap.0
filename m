From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 0/4] Updates on mcbsp driver (take #2)
Date: Mon, 19 May 2008 11:09:43 -0400
Message-ID: <a0580c510805190809l58f507eck62a13f659524b969@mail.gmail.com>
References: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
	 <5e088bd90805190726v69f5d7coc9eebb65d915ff7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:33917 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761233AbYESPJq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2008 11:09:46 -0400
Received: by py-out-1112.google.com with SMTP id u52so1922410pyb.10
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2008 08:09:45 -0700 (PDT)
In-Reply-To: <5e088bd90805190726v69f5d7coc9eebb65d915ff7a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chandra shekhar <x0044955@ti.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Steve,

This series is basically a simple transformation of currect mcbsp code
to a platform
driver and a separation of machine specific code.

It should work for omap1 and omap2 (what is currently supported). But
it should add basic support  for omap3
mcbps 1 and 2. Chandra will send his patches on top of this series to
add more features for omap3.

On Mon, May 19, 2008 at 10:26 AM, Steve Sakoman <sakoman@gmail.com> wrote:
> What's the current status of this patch series?  Haven't seen too much
> discussion.
>
> I've started work on a SoC driver for the OMAP3 EVM and want to make
> sure I'm using the latest.
>
> Regards,
>
> Steve
>
> On Mon, May 5, 2008 at 2:23 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
>> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>>
>> Hi Tony,
>>
>> Here is the updated version of my previous patches.
>> DMA and IRQ definitions were left as they are. Chandra is going
>> to send his work on top of this series.
>>
>> This patch series updates mcbsp driver by transforming it into
>> a platform driver. This is a very initial implementation.
>> Basically it moves machine specific code to their correct place
>> and creates the platform driver necessary structures.
>>
>> It must be working for previous boards. For omap34xx it should
>> work for mcbsp 1 and 2.
>>
>> In order to do not break other places, I tryied to do not change
>> previous API. But future improvements are needed.
>>
>> Clock definitions for  mcbsp 1 and 2 were also modified to add
>> correct support for omap34xx.
>>
>> Comments are wellcome.
>>
>> Cheers,
>>
>>
>> Eduardo Valentin (4):
>>  PLAT-OMAP: MCBSP: Tranform into platform driver
>>  MACH-OMAP1: MCBSP: Add support for mcbsp on mach-omap1
>>  Fix mcbsp clock definition on clock34xx.h
>>  MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2
>>
>>  arch/arm/mach-omap1/Makefile      |    2 +
>>  arch/arm/mach-omap1/mcbsp.c       |  165 +++++++++
>>  arch/arm/mach-omap2/Makefile      |    2 +
>>  arch/arm/mach-omap2/clock34xx.h   |   30 ++-
>>  arch/arm/mach-omap2/mcbsp.c       |  105 ++++++
>>  arch/arm/plat-omap/devices.c      |   45 +++
>>  arch/arm/plat-omap/mcbsp.c        |  660 ++++++++++++++-----------------------
>>  include/asm-arm/arch-omap/mcbsp.h |   73 ++++-
>>  8 files changed, 661 insertions(+), 421 deletions(-)
>>  create mode 100644 arch/arm/mach-omap1/mcbsp.c
>>  create mode 100644 arch/arm/mach-omap2/mcbsp.c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>



-- 
Eduardo Bezerra Valentin
