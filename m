From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
Date: Thu, 17 Feb 2011 18:24:59 -0600
Message-ID: <AANLkTikUt=GHVW1AEzm4gLCL1Be6eK+qJti=a1KR2N7H@mail.gmail.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
	<1296674843-12718-4-git-send-email-omar.ramirez@ti.com>
	<4D5943A9.8010205@ti.com>
	<AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
	<4D5AF8BA.8080403@ti.com>
	<AANLkTi=yj2_bS1h87u0hhUUpA=RPZe-A=PiNSf_q_66r@mail.gmail.com>
	<20110217233908.GG20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38136 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752040Ab1BRAZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 19:25:00 -0500
Received: by mail-gy0-f173.google.com with SMTP id 5so1545701gye.32
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 16:24:59 -0800 (PST)
In-Reply-To: <20110217233908.GG20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Thu, Feb 17, 2011 at 5:39 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ramirez Luna, Omar <omar.ramirez@ti.com> [110215 16:11]:
>>
>> > If you have to do several platform_get_irq_byname to get this one, I'd
>> > prefer to get rid of that name for OMAP4. It will make mailbox irq
>> > consistent with the other hwmods.
>>
>> I was thinking to standardize the names to be mbox0..mboxN across all
>> the platforms, reason being that the mailbox also has capabilities to
>> be used not only by dsp or iva, by using a polling method.
>>
>> So even if the mailbox in OMAP3 is called "dsp", it has 4 more queues
>> apart from the 2 used for messaging between arm and dsp, that could be
>> used even if tidspbridge wasn't there.
>
> So what's the status of this series? Can the rest of the patches
> now be applied on top of the current omap-for-linus or do the names
> still need fixing?

I'm going to remove the names for the hwmods with a single irq. And
change the interface clock to be the main_clk, so it can be disabled
when runtime pm is disabled.

I won't resend the patch for OMAP4 hwmod data, as this was send
earlier by Benoit.

Regards,

Omar
