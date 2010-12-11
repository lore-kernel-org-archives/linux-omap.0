From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific accessor/mutatorfunctions
Date: Sat, 11 Dec 2010 13:02:08 +0530
Message-ID: <a7496daab729031fd82a064513659761@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
 <20101208061829.30541.99531.stgit@twilight.localdomain> <0adb8bf19a1586d582ac168dcbfc4f5e@mail.gmail.com>
 <alpine.DEB.2.00.1012101839460.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34272 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914Ab0LKHcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Dec 2010 02:32:09 -0500
Received: by pwj6 with SMTP id 6so1420443pwj.40
        for <linux-omap@vger.kernel.org>; Fri, 10 Dec 2010 23:32:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012101839460.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Saturday, December 11, 2010 7:26 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Rajendra Nayak; Benoit Cousson
> Subject: RE: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific
> accessor/mutatorfunctions
>
> On Wed, 8 Dec 2010, Santosh Shilimkar wrote:
>
> > One more possible road block of removing the direct register access
> > from PM code is DEVICE PRM module. Even with this clean-up for DEVCIE
> > PRM related registers. I guess we still need to use the lowest level
> > APIs.
>
> To clarify my comments, I'm not talking about replacing omap4_prm_*()
with
> omap4_prminst_*() for the device PRM cases.  I agree that is not
> desirable.  What I'd like to see is for the middle-level PM code, such
as
> pm*.c, to call functions that describe what they are actually trying to
do
> at a higher level, rather than writing to registers directly.
>
> I'll take the PRM_VOLTSETUP* registers as a rough example.  This may be
a
> bad example since we probably don't write to this directly from pm*.c
any
> more, but the basic idea is, rather than writing some mystery value to a
> register from the pm*.c code, we should write something like:
>
> int omap4_prm_regulator_set_ramp_up_duration(u32 ns, u8 starting_pwrst);
>
> which would then take care of computing the prescaler and count values
> appropriately given the current sys_clk and writing them to the register
> or returning an error if something is wrong.
>
> The long-term goal is to be able to reuse as much PM code as possible
> between all of the different OMAP2+ platforms.
>
Thanks for clarification. We are fully aligned here.

Regards,
Santosh
