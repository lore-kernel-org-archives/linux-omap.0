From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: Bug in omap2_nand_gpmc_retime? (was: Re: [PATCH] OMAP: fix gpmc
	nand setup when no timings supplied)
Date: Wed, 28 Apr 2010 20:56:25 +0530
Message-ID: <s2hce9ab5791004280826y69ec56d1od0950eadf7cd60e6@mail.gmail.com>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
	<4BCFDC6F.6010801@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com>
	<4BCFF3C1.5070005@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7B5A@dbde02.ent.ti.com>
	<4BD00C9A.8050601@compulab.co.il> <20100426181448.GG7225@atomide.com>
	<4BD695BC.3080109@compulab.co.il> <20100427144734.GX7225@atomide.com>
	<4BD84EAF.7010104@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49006 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab0D1P0u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 11:26:50 -0400
Received: by vws19 with SMTP id 19so351646vws.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 08:26:49 -0700 (PDT)
In-Reply-To: <4BD84EAF.7010104@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Apr 28, 2010 at 8:35 PM, Mike Rapoport <mike@compulab.co.il> wr=
ote:
> Tony Lindgren wrote:
>>
>> * Mike Rapoport <mike@compulab.co.il> [100427 00:40]:
>>>
>>> Tony Lindgren wrote:
>>>>
>>>> * Mike Rapoport <mike@compulab.co.il> [100422 01:41]:
>>>>>
>>>>> Ghorai, Sukumar wrote:
>>>>>
>>>>> CM-T35, for instance can be assembled with different NAND flash
>>>>> chips. Besides, boards that use NAND as primary boot device, we
>>>>> anyway depend on proper GPMC configuration in the bootloader chai=
n.
>>>>> Having ability to define GPMC timings in the kernel and keep the
>>>>> settings made by the bootloader adds flexibility level for board
>>>>> designers.
>>>>
>>>> Not implementing the retime function for GPMC will cause issues
>>>> with PM as you cannot scale the L3 frequency without breaking
>>>> your GPMC timings.
>>>
>>> I agree that without retime function scaling the frequency will
>>> break the GPMC timings. But my point was that there should be an
>>> _option_ to keep the timings defined by the bootloader rather than
>>> enforce board files to specify timings.
>>
>> Sure. Can you please check one more time your patch and what is
>> still missing after Stanley's fix? That's now in omap-fixes and mast=
er
>> branches as commit 11e1ef2d105900a302b7ca92bcaf96a96d0274a1.
>>
>>> Since skipping the retime function will break gpmc timings in
>>> PM-enabled =A0kernel, we need to implement this option in smarter w=
ay.
>>> E.g. something like:
>>
>> Yeah we should print some warning if the retime function is not
>> implemented as it can cause mysterious bugs later on. I guess
>> implementing a dummy retime function would be best as then the
>> warning would be related to the actual L3 rate change.
>
> While working on implementation of gpmc_nand_detect_timings I've seen=
 that
> omap2_nand_gpmc_retime converts the timings supplied by the platform =
to
> ticks and passes it to gpmc_cs_set_timings which in turn converts the
> timings to ticks. Is it a bug or am I missing something?

No, 'omap2_nand_gpmc_retime' does not convert timings supplied by the
platform to tick. Rather it rounds the timings passed by the platform
to timings in units of 'tick' period.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
