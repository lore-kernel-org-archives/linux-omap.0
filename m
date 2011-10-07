From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Fri, 07 Oct 2011 23:50:04 +0530
Message-ID: <4E8F42D4.7030502@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local> <20111005004539.26980.52409.stgit@kaulin.local> <alpine.LFD.2.02.1110042059110.9106@xanadu.home> <20111005220619.GC6324@atomide.com> <4E8E9EE8.8010106@ti.com> <20111007144349.GE6324@atomide.com> <4E8F14A6.5050402@ti.com> <20111007151116.GI6324@atomide.com> <4E8F395B.9070203@ti.com> <20111007181621.GJ6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48410 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859Ab1JGSUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 14:20:13 -0400
Received: by mail-yx0-f173.google.com with SMTP id 11so5093968yxl.18
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 11:20:08 -0700 (PDT)
In-Reply-To: <20111007181621.GJ6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 07 October 2011 11:46 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [111007 10:05]:
>>
>> I initially tried some thing similar but the issue was GP and
>> HS devices. SRAM_PA isn't same on GP and EMU device and hence
>> did that dynamically. One way is I can make GP and HS
>> device SRAM_PA same for OMAP4 (Will loose 16 KB of
>> SRAM on OMAP4 GP). It's ok to loose that 16 KB SRAM
>> for OMAP4 with errata enabled.
> 
> Oh yeah, the beginning is different too, I forgot that.
>  
>> Below change works on both GP and HS device
>> If you are OK with it, I can update errata patch accordingly.
> 
> OK to me to loose 16KB when the errata is enabled. That can
> be fixed later on for example by passing the SRAM area from
> device tree.
>
Yep.

> I assume now you can add the mapping to io.c instead? If so,
> then it's easier to apply the patches whatever way makes more
> sense.
> 
io.c change I took as you suggested. The below change on top
of it. I just updated PM branch with this change.

Thanks for the tip. The errata code looks bit more clean
now. :)

Regards
Santosh
