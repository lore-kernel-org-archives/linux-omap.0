From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control module registers and APIs
Date: Tue, 13 Aug 2013 12:11:05 -0700
Message-ID: <87bo51jtiu.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-3-git-send-email-d-gerlach@ti.com>
	<5203A0BC.8060205@ti.com> <5203C457.80301@ti.com>
	<20130809051146.GB7656@atomide.com> <52055733.70808@ti.com>
	<87y586pvkq.fsf@kernel.org> <5209565C.7090508@ti.com>
	<87d2phpsu1.fsf@kernel.org> <520A4BE7.7090603@ti.com>
	<87wqnplg1n.fsf@kernel.org> <520A785C.3000304@ti.com>
	<CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:48783 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab3HMTLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 15:11:10 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so9288906pad.14
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 12:11:09 -0700 (PDT)
In-Reply-To: <CA+Bv8Xbg9v4zRy-EJPsxwCdwpSy50V8SjwQfmAvVxiCR=6mYBw@mail.gmail.com>
	(Russ Dill's message of "Tue, 13 Aug 2013 11:30:40 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russ Dill <russ.dill@gmail.com> writes:

>>>> ARM world is also moving towards that by standardizing some of these
>>>> through (read PSCI) and thats the way to go in general.
>>>
>>> Agreed, but I'm not sure (yet) about enforcing PSCI on legacy platforms
>>> that don't support it natively.  Are you saying that the AM33xx firmware
>>> should be converted to be PSCI compliant?  Admittedly, I haven't read
>>> the PSCI spec closely, but I'm wondering if the current role splitting
>>> between MPU and M3 fits well with PSCI.
>>>
>> I didn't mean for the AM3XXX specifically because its current job is rather
>> very limited. i.e suspend. My concern is that IPC is not viewed as
>> an option for power management controllers like M3 which can abstract
>> all the hardware gory details and export a simpled interface for OS
>> in form of PSCI/ACPI.
>
> The IPC between the M3 and the A8 on the am335x is just a pair of
> notification mechanisms (one from the A8, mailbox, and one from the
> M3, sev) and a set of 8 32 bit registers. The 8 32 bit registers are
> just a scratchpad and have no access rules or functionality beyond
> being a scratchpad. How complicated do we want to make this?

The OMAP IPC between the MPU and DSP (read: any other remote processor)
is just a mailbox and some shared memory.  No complicated, and works
with remoteproc/rpmsg.

What's more complicated? reusing existing frameworks or re-inventing
them?  Don't forget that "simple" drivers rarely stay that way.

Also, this is not a hard stance on my part.  I just need to be
convinced.  

The fact is that there are existing frameworks for doing what is being
proposed here.  Either use the existing frameworks, or make a technical
argument based on why those frameworks are not a good fit (ideally,
after having tried to use those frameworks.)

Once again, I'm pretty sure I mentioned this in earlier reviews of this
series.

Kevin
