From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] omap3evm: Add Mistral WL12XX config support
Date: Thu, 16 Jun 2011 14:20:27 +0200
Message-ID: <BANLkTi=XocYNPwuB2_-T8AHQkfEuzUnd9Q@mail.gmail.com>
References: <1308053788-25937-1-git-send-email-shahar@wizery.com>
	<20110614123359.GB23145@atomide.com>
	<BANLkTikE_caRE9uD6KN7h7OcY4nyUoRk9g@mail.gmail.com>
	<20110614135518.GH23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47030 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959Ab1FPMU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 08:20:28 -0400
Received: by pvg12 with SMTP id 12so1024387pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 05:20:27 -0700 (PDT)
In-Reply-To: <20110614135518.GH23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Shahar Lev <shahar@wizery.com>, linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Shahar, Tony,

On Tue, Jun 14, 2011 at 3:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shahar Lev <shahar@wizery.com> [110614 06:21]:
>> On Tue, Jun 14, 2011 at 3:34 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > This your should try to remove as it won't work nicely for supporting
>> > various boards with the same kernel as we already do with
>> > omap2plus_defconfig.
>> >
>> > Can you somehow detect the daughter board dynamically and then
>> > set the flags?
>> >
>>
>> We thought about multi-board kernels, but unfortunately have no
>> better solution, since there is no dynamic way to probe these cards.
>> Even worse, these cards sometimes come with different clocks in them,
>> hence the 2nd OMAP3EVM_MISTRAL_WL12XX_REFCLOCK entry we had to
>> introduce...
>>
>> Maybe we should add two bootargs with which the user can override this
>> Kconfig configuration? This should allow using the same kernel binary
>> with different omap3evm boards.

You won't need Kconfig parameters then. Just have module parameters
and supply whatever default values you find reasonable.

~Vitaly
