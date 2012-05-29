From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 10/19] ARM: OMAP4: PM: Work-around for ROM code BUG of IVAHD/TESLA
Date: Tue, 29 May 2012 13:13:18 -0700
Message-ID: <87y5oag2zl.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-11-git-send-email-t-kristo@ti.com>
	<87zk976827.fsf@ti.com> <4FB43329.50505@ti.com>
	<1337591500.28274.5.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46834 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754531Ab2E2UNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 16:13:20 -0400
Received: by dadm1 with SMTP id m1so6249231dad.8
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 13:13:19 -0700 (PDT)
In-Reply-To: <1337591500.28274.5.camel@sokoban> (Tero Kristo's message of
	"Mon, 21 May 2012 12:11:40 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> On Wed, 2012-05-16 at 16:07 -0700, Kevin Hilman wrote:
>> On 05/16/2012 04:05 PM, Kevin Hilman wrote:
>> > Tero Kristo<t-kristo@ti.com>  writes:
>> >
>> >> From: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> >>
>> >> The ROM BUG is when MPU Domain OFF wake up sequence that can compromise
>> >> IVA and Tesla execution.
>> >>
>> >> At wakeup from MPU OFF on HS device only (not GP device), when
>> >> restoring the Secure RAM, the ROM Code reconfigures the clocks the
>> >> same way it is done at Cold Reset.
>> >
>> > Ouch.
>> >
>> >> The IVAHD Clocks and Power Domain settings are:
>> >> 	IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE = DISABLE
>> >> 	IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE = DISABLE
>> >> 	IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL = HW_AUTO
>> >> 	IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE = OFF
>> >> The TESLA Clocks and Power Domain settings are:
>> >> 	TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE = DISABLE
>> >> 	TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL = HW_AUTO
>> >> 	TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE = OFF
>> >>
>> >> This patch fixes the low power OFF mode code so that the these
>> >> registers are saved and restore across MPU OFF state.
>> >>
>> >> Also because of this limitation, MPU OFF alone is not targeted without
>> >> device OFF to avoid IVAHD and TESLA execution impact
>> >
>> > I don't see where this restriction is implemented.
>> >
>> > And, can this be hooked into cluster PM notifiers.
>> 
>> Especially since this only effects a subset of revisions, installing the 
>> notifier only on effected revisions also removes any overhead on working 
>> revisions.
>
> Where would you recommend adding the notifiers to? Just to the same file
> or...? pm44xx.c?

Same file should be ok.

Kevin
