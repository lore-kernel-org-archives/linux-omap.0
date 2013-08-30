From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Fri, 30 Aug 2013 14:18:38 -0700
Message-ID: <87ioymop1t.fsf@linaro.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<87mwo2vmds.fsf@linaro.org>
	<CANacCWwNp4yg0e_9HPJCGJgQkaYP1n=b6Kjmw9KYjp6HoOY0og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:57771 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3H3VSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 17:18:42 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so2338835pdj.6
        for <linux-omap@vger.kernel.org>; Fri, 30 Aug 2013 14:18:41 -0700 (PDT)
In-Reply-To: <CANacCWwNp4yg0e_9HPJCGJgQkaYP1n=b6Kjmw9KYjp6HoOY0og@mail.gmail.com>
	(Vaibhav Bedia's message of "Fri, 30 Aug 2013 13:39:21 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lingren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Vaibhav Bedia <vaibhav.bedia@gmail.com> writes:

> On Tue, Aug 27, 2013 at 5:45 PM, Kevin Hilman <khilman@linaro.org> wrote:
> [...]
>>
>> Looking closer at this code as I'm trying to fully get my head around
>> all the IPC, I have some more comments.
>>
>> I think the split between pm33xx.c and the M3 driver is still confusing
>> here.  For example, am33xx_ping_wkup_m3(),
>> am33xx_m3_state_machine_reset() and the guts of am33xx_pm_begin() all
>> belong inside the M3 driver, along with all the wakeup_src stuff, which
>> is info coming from the M3.
>>
>> IOW, the communication with M3 should be abstracted from pm33xx by the
>> M3 driver (or possibly an eventual remoteproc/rpmsg implementation) with
>> a well defined API.  In this implementation, the interface is pretty
>> fuzzy and mixed between pm33xx.c and wkup_m3.c.
>>
>>
>
> The reason for the current split was to have the M3 driver just do the minimal
> that's needed to talk to get M3 and MPU talking. What made me do it this way
> was to attempt to address a previous comment on keeping options open for folks
> to use M3 for things other than PM stuff. The IPC stuff is how
> implementors of the
> firmware (anything other than the PM one that TI provides) want it to be.

IMO, there should actually be 3 levels. the SoC PM implementation
(pm33xx.c), the M3 driver where the protocol, state-machine, etc. are
handled, and the messaging layer.  In the current proposal, the last 2
are combined, but I'd really like to see a generalized messaging layer
that everyone else using an M3 coprocessor might use as well.  As
mentioned already, I think that should be rpmsg, but that still needs
some exploration.

> The top level idea was to have the users of the firmware (PM in this case)
> decide what functionality they want when talking to M3. They are also free to
> decide the register bitfield layout and other IPC details.
>
> This was also a feeble attempt to keep things extensible for AM437x where
> in addition to the broken mailbox usage there's now a control module bit
> to trigger the interrupt to M3 (what's worse? pick one that you hate more ;)

Sounds like AM43xx is better.  If you have a control module bit to
trigger an interrupt, why do you need the mailbox at all?

> The AM437x PM routines could then just register different callbacks that
> are triggered when the M3 interrupts the MPU.
>
> Hope this clears up some of the confusion.

Thanks,

Kevin
