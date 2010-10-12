From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] OMAP: control: add functions for DSP boot
 address/mode control
Date: Tue, 12 Oct 2010 14:01:17 +0300
Message-ID: <AANLkTinwZ87BepJE9RuxJ6BitQ9N5dWTDT7WZTJHNqNO@mail.gmail.com>
References: <20101011203659.24425.2381.stgit@twilight.localdomain>
	<20101011203710.24425.94685.stgit@twilight.localdomain>
	<AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com>
	<alpine.DEB.2.00.1010111449240.16871@utopia.booyaka.com>
	<20101011211616.GE25462@atomide.com>
	<alpine.DEB.2.00.1010111519410.16871@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59918 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab0JLLBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 07:01:19 -0400
Received: by bwz15 with SMTP id 15so2305650bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 12 Oct 2010 04:01:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1010111519410.16871@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, fernando.lugo@ti.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

On Tue, Oct 12, 2010 at 12:35 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Mon, 11 Oct 2010, Tony Lindgren wrote:
>> Would be nice to get the dspbridge into working shape. Sounds we sti=
ll
>> need the following:
>>
>> - memblock fixes
>> - this series to fix the control module related issues
>> - platform data for the boards
>>
>> Is that all, or are we also missing something else?
>
> A few other things should be done also.
>
> 1. Most of the code in drivers/staging/tidspbridge/code/tiomap3430.c =
in
> the bridge_brd_monitor(), bridge_brd_start(), and bridge_brd_stop() s=
hould
> be moved into a file in arch/arm/mach-omap2. =C2=A0The DSPBridge driv=
er should
> call those functions (to reset the DSP, start it, etc.) through
> platform_data function pointers. =C2=A0Once that happens, patch 3 of =
the
> control module-related series would not be needed, since that code wo=
uld
> be in arch/arm/mach-omap2 anyway.
>
> 2. The direct CM/PRM/RM register access should be removed from that
> arch/arm/mach-omap2 code. =C2=A0That should be handled directly by th=
e
> clock/hwmod/whatever code.
>
> 3. DSPBridge should be converted to use PM runtime, and the
> arch/arm/mach-omap2 portion should use omap_device, omap_hwmod, etc.

Before starting to clean things up, I would rather have something that
works, which AFAIK includes:

 1) revert or fix iommu migration
 2) fix ioremap() usage on RAM

Only then we can have some minimal confidence that the cleaning up is
not introducing further breakage.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
