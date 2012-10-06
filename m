From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP mode
Date: Sat, 06 Oct 2012 18:06:51 +0200
Message-ID: <5d2c2df8247d9f028727f9a8b712d3d4@localhost>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com> <1347036934-8519-3-git-send-email-marc.zyngier@arm.com> <20121005200822.GQ3874@atomide.com> <6d3553bfe8a2d1ac88cab852100616a7@localhost> <20121006144252.GY3874@atomide.com> <alpine.LFD.2.02.1210061129080.16518@xanadu.home> <20121006154052.GB3874@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:56684 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754411Ab2JFQG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 12:06:56 -0400
In-Reply-To: <20121006154052.GB3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Sat, 6 Oct 2012 08:40:52 -0700, Tony Lindgren <tony@atomide.com> wrote:
> * Nicolas Pitre <nicolas.pitre@linaro.org> [121006 08:33]:
>> On Sat, 6 Oct 2012, Tony Lindgren wrote:
>> 
>> > * Marc Zyngier <marc.zyngier@arm.com> [121006 03:19]:
>> > 
>> > > If so, that indicates some side effect of the safe_svcmode_maskall
>> > > macro,
>> > > and I suspect the "movs pc, lr" bit.
>> > > 
>> > > Can you try the attached patch? It basically falls back to the
>> > > previous
>> > > behaviour if not entered in HYP mode.
>> > 
>> > Yes, with this it boots OK.
>> 
>> OK. In that case, I suggest this patch be sent to Russell to fix this 
>> issue so he could push the ARM stuff to Linus ASAP.
>> 
>> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Yes we can come back to this:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Now in Russell's patch system as #7549/1.

Thanks a lot for your help on this both of you.

        M.
-- 
Fast, cheap, reliable. Pick two.
